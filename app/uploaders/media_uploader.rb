class MediaUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  version :size_300_x_300 do
    resize_to_fit(300, 300)
  end

end