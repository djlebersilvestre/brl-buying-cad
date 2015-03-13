class ExchangeHouse < ActiveRecord::Base
  has_many :rates

  validates :name, presence: true, uniqueness: true
end
