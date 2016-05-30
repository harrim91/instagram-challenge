class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  validates :user_name, presence: true, length: { minimum: 3, maximum: 20 }

  has_many :pictures, dependent: :destroy
  has_many :comments, dependent: :destroy
  acts_as_voter
end
