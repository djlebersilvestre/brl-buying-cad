class ExchangeHouse < ActiveRecord::Base
  validates :name, presence: true
end
