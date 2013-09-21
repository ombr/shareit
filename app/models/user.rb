class User < ActiveRecord::Base

  has_many :posts
  has_many :items

  serialize :box_credentials

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  def confirmation_required?
    false
  end

  def box_client
    session = RubyBox::Session.new({
      client_id: ENV['BOX_CLIENT_ID'],
      client_secret: ENV['BOX_CLIENT_SECRET'],
      access_token: self.box_credentials[:token]
    })
    client = RubyBox::Client.new(session)
    new_token = session.refresh_token(self.box_credentials[:refresh_token])
    self.box_credentials = {
      token: new_token.token,
      refresh_token: new_token.refresh_token
    }
    self.save!
    session = RubyBox::Session.new({
      client_id: ENV['BOX_CLIENT_ID'],
      client_secret: ENV['BOX_CLIENT_SECRET'],
      access_token: new_token.token
    })
    RubyBox::Client.new(session)
  end
end
