class Subattachment < ActiveRecord::Base
  belongs_to :post
  mount_uploader :media, MediaUploader
end