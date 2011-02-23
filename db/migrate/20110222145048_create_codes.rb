class CreateCodes < ActiveRecord::Migration
  def self.up
    create_table :codes do |t|
      t.integer :area_code # to be filled in later
      t.string :zip_code

      t.references :city
      t.timestamps

      t.add_index :zip_code
    end
  end

  def self.down
    drop_table :area_codes
  end
end
