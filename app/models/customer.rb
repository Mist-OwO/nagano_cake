class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :addresses
  has_many :cart_items
  has_many :orders
  
  validates :email, presence: true, uniqueness: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :telephone_number, presence: true
  validates :postal_code, presence: true, length: {maximum:7}
  validates :address, presence: true
  
  def active_for_authentication?
    super && (is_deleted == false)
  end
end
