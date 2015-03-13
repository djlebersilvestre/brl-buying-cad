class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.references :exchange_house, index: true, null: false
      t.timestamp :read_at, null:false
      t.float :value, null:false
    end
    add_foreign_key :rates, :exchange_houses
  end
end
