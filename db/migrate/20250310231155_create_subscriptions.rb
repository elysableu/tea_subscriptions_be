class CreateSubscriptions < ActiveRecord::Migration[7.2]
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.decimal :price, precision: 10, scale: 2
      t.string :status
      t.string :frequency

      t.timestamps
    end
  end
end
