class Order < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0.00 }
end
