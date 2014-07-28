class Artist < ActiveRecord::Base
  belongs_to :stage

  validates :day,   inclusion: { in: %w(vendredi samedi dimanche) }
  validates :hour,  presence: true
  validates :name,  presence: true, uniqueness: { scope: :stage }
  validates :stage, presence: true
end
