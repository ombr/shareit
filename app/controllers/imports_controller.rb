class ImportsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @facebook_url = user_omniauth_authorize_path(:facebook, scope: 'read_friendlists')
    @box_url = RubyBox::Session.new({
      client_id: ENV['BOX_CLIENT_ID'],
      client_secret: ENV['BOX_CLIENT_SECRET']
    }).authorize_url(ENV['BOX_AUTHORIZE_URL'])
  end

  def box
    if params[:code].blank?
      return redirect_to root_path
    end
    session = RubyBox::Session.new({
      client_id: ENV['BOX_CLIENT_ID'],
      client_secret: ENV['BOX_CLIENT_SECRET']
    })

    token = session.get_access_token(params[:code])
    current_user.box_credentials = {
      token: token.token,
      refresh_token: token.refresh_token
    }
    current_user.save!
    Import.box_folder(current_user, '/')
    flash[:notice] = 'Your files will be imported soon :-D'
    redirect_to root_path
  end
end
