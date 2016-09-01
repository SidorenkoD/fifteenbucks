class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :title, null: false
      t.decimal :amount
      t.references :user, index: true
    end
  end
end
