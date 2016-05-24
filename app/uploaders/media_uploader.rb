class MediaUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  version :standard do
    process :resize_to_fill => [800, 800, :north]
  end

  version :default do
    resize_to_fit(300, 300)
  end

end