# encoding: utf-8

class ItemUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  def extension_white_list
     %w(jpg jpeg gif png)
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  end

  process :resize_to_fit => [1000,1000]
  process :fix_exif_rotation

  version :thumb do
    process :resize_to_fill => [200,200]
    process :strip
  end

end
