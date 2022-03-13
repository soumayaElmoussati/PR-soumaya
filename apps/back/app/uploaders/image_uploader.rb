class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def size_range
    0..2.gigabytes
  end

  process :convert => 'png'
  process :resize_to_limit => [1200, 1200]

  version :thumbnail do
    resize_to_fit(300, 220)
  end
end
