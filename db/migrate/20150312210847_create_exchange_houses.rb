class CreateExchangeHouses < ActiveRecord::Migration
  def change
    create_table :exchange_houses do |t|
      t.string :name, null: false
    end
  end
end
