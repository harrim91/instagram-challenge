class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  validates :user_name, presence: true, length: { minimum: 3, maximum: 20 }

  has_many :pictures, dependent: :destroy
end
