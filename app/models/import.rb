class Import
  class << self
    def get_client token, refresh_token
      session = RubyBox::Session.new({
        client_id: ENV['BOX_CLIENT_ID'],
        client_secret: ENV['BOX_CLIENT_SECRET'],
        access_token: token
      })
      new_token = session.refresh_token(refresh_token)
      puts "client = Import.get_client '#{new_token.token}', '#{new_token.refresh_token}'"
      session = RubyBox::Session.new({
        client_id: ENV['BOX_CLIENT_ID'],
        client_secret: ENV['BOX_CLIENT_SECRET'],
        access_token: new_token.token
      })
      RubyBox::Client.new(session)
    end
    def parent_path item
     names = item.path_collection.entries.map{|i| i['name']}
     names[0] = '' #Remove All Files/
     return names.join('/')
    end
    def path item
      return '/' if item.parent.nil?
      "#{parent_path item}/#{item.name}"
    end
    def import_folder folder
      puts "> Import Folder #{path folder}"
      folder.items.each do |item|
        case item
        when RubyBox::Folder
          import_folder item
        else
          puts "> Import File : #{path item}"
          Tempfile.open(['prefix',item.name], Rails.root.join('tmp'), encoding: 'ascii-8bit') do |file|
            puts 'Download'
            file.write item.download
            puts 'done'
            Item.create!(
              path: path(item),
              file: file
            )
            puts 'Create Item'
          end
          puts item.class
          puts item.inspect
        end
      end
    end
    def box_import token, refresh_token
      client = get_client token, refresh_token
      import_folder client.folder('/')
    end
    handle_asynchronously :box_import
  end
end
