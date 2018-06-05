class Order < ApplicationRecord
  belongs_to :user
  enum status: {pending: 0, checked: 1}
  has_many :order_details, dependent: :destroy
  scope :filter_by_status, ->(status){where(status: status) if status.present?}
  validates :phone, presence: true, numericality: {only_integer: true}
  validates :address, presence: true, length: {maximum: 10,
    minimum: 5}
end
