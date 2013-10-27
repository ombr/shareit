class Devise::OmniauthCallbacksController < ApplicationController
  def failure
    redirect_to root_path
  end
  def facebook
    raise 'not yet implemented' if not current_user
    #raise request.env["omniauth.auth"].credentials.to_hash.inspect
    current_user.update!( facebook_credentials: request.env["omniauth.auth"].credentials.to_hash )
    #current_user.update!(
      #provider: request.env['omniauth.auth']['provider'],
      #uid: request.env['omniauth.auth']['uid'],
      #name: request.env['omniauth.auth']['info']['name']
    #)
    Facebook.delay.import current_user
    return redirect_to root_path
  end
end
