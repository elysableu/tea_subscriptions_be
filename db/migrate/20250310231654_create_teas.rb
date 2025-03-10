class CreateTeas < ActiveRecord::Migration[7.2]
  def change
    create_table :teas do |t|
      t.string :title
      t.string :description
      t.decimal :temperature, precision: 5, scale: 2
      t.string :brew_time

      t.timestamps
    end
  end
end
