class Rate < ActiveRecord::Base
  belongs_to :exchange_house, required: true

  validates :created_at, :value, presence: true
end
