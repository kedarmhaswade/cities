require "activerecord-import"

# Example of doing more in the migration code

class AssociateCodesToStates < ActiveRecord::Migration
  def self.up
    change_table :codes do |t|
      t.remove_column :city_id
      t.references :state
    end

  end

  def self.down
  end
end
