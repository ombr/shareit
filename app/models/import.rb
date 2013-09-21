class Import
  class << self
    def parent_path item
     names = item.path_collection.entries.map{|i| i['name']}
     names[0] = '' #Remove All Files/
     return names.join('/')
    end
    def path item
      return '/' if item.parent.nil?
      "#{parent_path item}/#{item.name}"
    end

    def box_file user, file_name
      puts "> #{user.email} >Import File #{file_name}"
      file = user.box_client.file(file_name)
      Tempfile.open(['prefix',file.name], Rails.root.join('tmp'), encoding: 'ascii-8bit') do |tmp_file|
        puts 'Download'
        tmp_file.write file.download
        puts 'done'
        Item.create!(
          path: file_name,
          file: tmp_file,
          user: user
        )
        puts 'Created !'
      end
    end

    def box_folder user, folder_name
      puts "> #{user.email} >Import Folder #{folder_name}"
      folder = user.box_client.folder(folder_name)
      folder.items.each do |item|
        case item
        when RubyBox::Folder
          box_folder_without_delay user, path(item)
        when RubyBox::File
          box_file user, path(item)
        else
          raise 'What\'s that ??'
        end
      end
    end
    handle_asynchronously :box_folder
  end
end
