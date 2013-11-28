class User < ActiveRecord::Base

  has_many :posts
  has_many :items
  has_many :groups
  has_many :memberships

  serialize :box_credentials
  serialize :facebook_credentials

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable
  devise :omniauthable, :omniauth_providers => [:facebook]

  def box_client
    session = RubyBox::Session.new({
      client_id: ENV['BOX_CLIENT_ID'],
      client_secret: ENV['BOX_CLIENT_SECRET'],
      access_token: self.box_credentials[:token]
    })
    client = RubyBox::Client.new(session)
    last_update = box_credentials[:last_update]
    return client if last_update and last_update >= 45.minutes.ago
    new_token = session.refresh_token(self.box_credentials[:refresh_token])
    self.box_credentials = {
      token: new_token.token,
      refresh_token: new_token.refresh_token,
      last_update: Time.zone.now,
    }
    self.save!
    session = RubyBox::Session.new({
      client_id: ENV['BOX_CLIENT_ID'],
      client_secret: ENV['BOX_CLIENT_SECRET'],
      access_token: new_token.token
    })
    RubyBox::Client.new(session)
  end

  def avatar(size)
    return "http://graph.facebook.com/#{uid}/picture?width=#{size}&height=#{size}" if uid.present?
    GravatarImageTag.gravatar_url(email, size: size)
  end

end
