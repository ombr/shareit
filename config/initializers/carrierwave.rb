#https://gist.github.com/mariovisic/965983
module CarrierWave
  module RMagick
 
    # Rotates the image based on the EXIF Orientation
    def fix_exif_rotation
      manipulate! do |img|
        img.auto_orient!
        img = yield(img) if block_given?
        img
      end
    end
 
    # Strips out all embedded information from the image
    def strip
      manipulate! do |img|
        img.strip!
        img = yield(img) if block_given?
        img
      end
    end
 
    # Reduces the quality of the image to the percentage given
    def quality(percentage)
      manipulate! do |img|
        img.write(current_path){ self.quality = percentage }
        img = yield(img) if block_given?
        img
      end
    end
 
  end
end

CarrierWave.configure do |config|
  if Rails.env.test? or Rails.env.cucumber? or Rails.env.development?
    config.storage = :file
    #config.enable_processing = false
  else
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['AWS_KEY'],
      :aws_secret_access_key  => ENV['AWS_SECRET']
    }
    config.fog_directory  = ENV['AWS_BUCKET']
  end
end
