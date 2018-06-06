class Product < ApplicationRecord
  belongs_to :category
  has_many :ratings
  has_many :comments
  has_many :order_details
  has_many :images, dependent: :destroy

  scope :order_product, ->{order created_at: :desc}
end
