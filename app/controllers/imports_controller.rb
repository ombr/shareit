class ImportsController < ApplicationController
  def index
  end
  def box
    session = RubyBox::Session.new({
      client_id: ENV['BOX_CLIENT_ID'],
      client_secret: ENV['BOX_CLIENT_SECRET']
    })
    if params[:code].blank?
      authorize_url = session.authorize_url(ENV['BOX_AUTHORIZE_URL'])
      redirect_to authorize_url
    else
      @token = session.get_access_token(params[:code])
      #session.access_token = @token.token
      #required ?
      session = RubyBox::Session.new({
        client_id: ENV['BOX_CLIENT_ID'],
        client_secret: ENV['BOX_CLIENT_SECRET'],
        access_token: @token.token
      })

      client = RubyBox::Client.new(session)
      @folder = client.folder('/subfolder')
      @folder.create_shared_link
      #raise client.folder('/').files.inspect
    end
  end
end
