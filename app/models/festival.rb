class Festival < ActiveRecord::Base
  has_one :organizer

  has_many :artists, through: :stages
  has_many :stages

  has_and_belongs_to_many :genres

  validates :name,          presence: true, uniqueness: true
  validates :price_per_day, presence: true, numericality: { greater_than: 10 }
end
