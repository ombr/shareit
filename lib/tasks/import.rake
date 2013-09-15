task :import, [:path] => :environment do |t, args|
  puts args[:path]
  Post.destroy_all
  Item.destroy_all
  #Dir.glob("#{args[:path]}/**/*.jpg").each do |item|
  Parallel.map(Dir.glob("#{args[:path]}/**/*.jpg"), in_process: 8) do |item|
    if File.exists?(item)
      local_path = item[args[:path].length..-1]
      item = Item.create!(
        path: local_path,
        file: File.open(item)
      )
      puts item.inspect
      item.save!
      puts local_path
    end
  end
end

