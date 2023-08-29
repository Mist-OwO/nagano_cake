class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_items

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true

  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
  # 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end
end