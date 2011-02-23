class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      t.string :name
      t.string :short

      t.timestamps

      t.add_index :name
      t.add_index :short
    end
  end

  def self.down
    drop_table :states
  end
end
