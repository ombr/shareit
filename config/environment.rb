# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Blog::Application.initialize!

ActionMailer::Base.smtp_settings = {
  user_name: ENV['SMTP_USERNAME'],
  password: ENV['SMTP_PASSWORD'],
  address: ENV['SMTP_HOST'],
  port: ENV['SMTP_PORT'],
  domain: ENV['DOMAIN'],
  authentication: :plain
}
