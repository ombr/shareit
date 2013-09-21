task :import, [:email, :path] => :environment do |t, args|
  puts args[:path]
  @user = User.find_by_email args[:email]
  Post.destroy_all
  Item.destroy_all
  #Parallel.map(Dir.glob("#{args[:path]}/**/*.jpg"), in_process: 8) do |item|
  Dir.glob("#{args[:path]}/**/*.jpg") do |item|
    if File.exists?(item)
      local_path = item[args[:path].length..-1]
      puts "import : #{item}"
      item = Item.create!(
        path: local_path,
        file: File.open(item),
        user: @user
      )
      puts item.inspect
      item.save!
      puts local_path
    end
  end
end

