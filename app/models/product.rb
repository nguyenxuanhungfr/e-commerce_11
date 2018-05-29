class Product < ApplicationRecord
  belongs_to :category
  has_many :ratings
  has_many :comments
  has_many :order_details

  scope :order_product, ->{order created_at: :desc}
  mount_uploader :images, PictureUploader

  validates :name, presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: Settings.product.max_length}
  validates_numericality_of :price, presence: true,
     numericality: {less_than_or_equal_to: Settings.product.max_price,
      greater_than_or_equal_to: Settings.product.min_price, only_integer: true}
  validates_numericality_of :quantity, numericality:
    {less_than_or_equal_to: Settings.product.max_quantity,
      greater_than_or_equal_to: Settings.product.min_quantity,
      only_integer: true}
  validate :images_size
  validates :description, presence: true
  validates :category_id, presence: true

  default_scope ->{order(created_at: :desc)}

  private

  def images_size
    if images.size > 5.megabytes
      errors.add :images, t("warning_size")
    end
  end
end
