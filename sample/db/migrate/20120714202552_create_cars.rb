class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :brand
      t.integer :year

      t.timestamps
    end
  end
end
