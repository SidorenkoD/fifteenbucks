class AddCardTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :card_token, :string
    add_column :orders, :status, :integer, default: 0
  end
end
