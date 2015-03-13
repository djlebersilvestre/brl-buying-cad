class Rate < ActiveRecord::Base
  belongs_to :exchange_house, required: true

  validates :created_at, :value, presence: true
  validates :exchange_house, uniqueness: { scope: :created_at }
end
