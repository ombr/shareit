class Facebook
  class << self
    def import user
      request(user, 'me/friendlists') do |lists|
        lists.each do |list|
          import_group user, list['id'], list['name']
        end
      end
    end

    def import_group user, id, name
      puts name
      group = Group.find_or_create_by user: user, name: name
      request(user, "#{id}/members") do |members|
        members.each do |member|
          import_member(group, member['id'], member['name'])
        end
      end
    end

    def import_user id, name
      user = User.find_or_create_by uid: id.to_s
      user.name = name
      user.email = "facebook-#{name.parameterize}@ombr.fr" if user.email.blank?
      user.password= Devise.friendly_token[0,20] if user.encrypted_password.blank?
      user.save!
      user
    end

    def import_member group, id, name
      user = import_user id, name
      user.memberships.find_or_create_by group: group
    end

    def request user, endpoint
      url = "https://graph.facebook.com/#{endpoint}?access_token=#{user.facebook_credentials['token']}"
      puts "FACEBOOK #{url}"
      response = HTTParty.get(url)
      json = JSON.parse(response)
      yield json['data']
    end
  end
end
