# encoding: utf-8

class ItemUploader < CarrierWave::Uploader::Base

  def extension_white_list
     %w(jpg jpeg gif png)
  end
   include CarrierWave::RMagick

  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  end

  version :thumb do
    process :resize_to_fill => [50,50]
  end

end
