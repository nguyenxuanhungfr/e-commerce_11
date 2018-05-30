class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :address
      t.string :phone
      t.boolean :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
