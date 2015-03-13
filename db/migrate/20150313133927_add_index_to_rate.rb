class AddIndexToRate < ActiveRecord::Migration
  def change
    add_index :rates, [:exchange_house_id, :read_at], unique: true
  end
end
