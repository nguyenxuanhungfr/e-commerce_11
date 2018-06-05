class Order < ApplicationRecord
  belongs_to :user
  enum status: {pending: 0, checked: 1}
  has_many :order_details, dependent: :destroy
  scope :filter_by_status, ->(status){where(status: status) if status.present?}
end
