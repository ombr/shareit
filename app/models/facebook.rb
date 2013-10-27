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
        #raise members.inspect
      end
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
