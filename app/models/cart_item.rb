class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
  validates :customer_id, presence: true
  validates :item_id, presence: true
  validates :amount, presence: true
  
  def subtotal
    item.with_tax_price * amount
  end

end