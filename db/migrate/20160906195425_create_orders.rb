class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :title, null: false
      t.decimal :amount, precision: 8, scale: 2
      t.references :user, index: true
    end
  end
end
