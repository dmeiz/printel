class CreateWheels < ActiveRecord::Migration
  def change
    create_table :wheels do |t|
      t.column :car_id, :integer

      t.timestamps
    end
  end
end
