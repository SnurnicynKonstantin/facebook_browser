class Group < ActiveRecord::Base
  has_many :posts, dependent: :destroy
end