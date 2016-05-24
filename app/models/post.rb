class Post < ActiveRecord::Base
  scope :sorted_by_past, -> { order(created_time: :desc) }

  has_many :contents, dependent: :destroy
  belongs_to :group
end