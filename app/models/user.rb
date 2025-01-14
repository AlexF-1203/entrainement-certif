class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
has_many :locations
has_many :appointments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
