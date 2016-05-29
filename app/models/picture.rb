class Picture < ActiveRecord::Base
  validates :image, presence: true
  has_attached_file :image, styles: { medium: '300' }
  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
