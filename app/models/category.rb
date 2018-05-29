class Category < ApplicationRecord
  has_many :products
  enum status: [:hide, :display]
end
