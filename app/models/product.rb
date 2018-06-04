class Product < ApplicationRecord
  belongs_to :category
  has_many :ratings
  has_many :comments
  has_many :order_details
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images,
    reject_if: ->(attrs) {attrs['image_url'].blank?}

  validates :name, presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: Settings.product.max_length}
  validates_numericality_of :price, presence: true,
     numericality: {less_than_or_equal_to: Settings.product.max_price,
      greater_than_or_equal_to: Settings.product.min_price, only_integer: true}
  validates_numericality_of :quantity, numericality:
    {less_than_or_equal_to: Settings.product.max_quantity,
      greater_than_or_equal_to: Settings.product.min_quantity,
      only_integer: true}
  validates :description, presence: true
  validates :category_id, presence: true

  scope :ordered, ->{order created_at: :asc}
  scope :search_by_name, ->(name){where("name LIKE ? ", "%#{name}%") if name.present?}
  scope :filter_by_category, ->(category_id){where(category_id: category_id) if category_id.present?}
end
