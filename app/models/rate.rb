class Rate < ActiveRecord::Base
  belongs_to :exchange_house, required: true

  validates :read_at, :value, presence: true
  validates :exchange_house, uniqueness: { scope: :read_at }
end
