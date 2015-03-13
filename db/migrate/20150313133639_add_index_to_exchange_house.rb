class AddIndexToExchangeHouse < ActiveRecord::Migration
  def change
    add_index :exchange_houses, :name, unique: true
  end
end
