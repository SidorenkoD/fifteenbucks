class Order < ActiveRecord::Base
  belongs_to :user
  enum status: { unpaid: 0, paid: 1 }

  validates :title, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0.5 }

  def in_cents
    (amount * 100).to_i
  end
end
