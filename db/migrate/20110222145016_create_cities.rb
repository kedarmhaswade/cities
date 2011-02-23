class CreateCities < ActiveRecord::Migration
  def self.up
    create_table :cities do |t|
      t.string :name
      t.float :longitude
      t.float :latitude
      t.references :state
      t.add_index :name
      t.timestamps
    end
  end

  def self.down
    drop_table :cities
  end
end
