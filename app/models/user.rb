class User < ActiveRecord::Base
  has_many :orders, dependent: :nullify
  validates :name, presence: true, uniqueness: true
end
