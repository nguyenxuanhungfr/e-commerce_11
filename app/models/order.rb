class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  validates :phone, presence: true, numericality: {only_integer: true}
  validates :address, presence: true, length: {maximum: Settings.settings.max_value_address,
    minimum: Settings.settings.min_value_address}
end
