class ImportsController < ApplicationController

  def index
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

    @token = session.get_access_token(params[:code])
    Import.box_import(@token.token, @token.refresh_token)
    flash[:notice] = 'Your files will be imported soon :-D'
    redirect_to root_path
  end
end
