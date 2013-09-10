class ImportsController < ApplicationController

  def index
    @box_url = RubyBox::Session.new({
      client_id: ENV['BOX_CLIENT_ID'],
      client_secret: ENV['BOX_CLIENT_SECRET']
    }).authorize_url(ENV['BOX_AUTHORIZE_URL'])
  end

  def box
    if params[:code].blank?
      return redirect root_path
    end
    session = RubyBox::Session.new({
      client_id: ENV['BOX_CLIENT_ID'],
      client_secret: ENV['BOX_CLIENT_SECRET']
    })

    @token = session.get_access_token(params[:code])

    session = RubyBox::Session.new({
      client_id: ENV['BOX_CLIENT_ID'],
      client_secret: ENV['BOX_CLIENT_SECRET'],
      access_token: @token.token
    })
    client = RubyBox::Client.new(session)
    @files = client.folder('/').files
  end
end
