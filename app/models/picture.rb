class Picture < ActiveRecord::Base
  validates :image, :user_id, presence: true
  has_attached_file :image,
                    styles: { thumbnail: '300', medium: '640' }

  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  belongs_to :user
end
