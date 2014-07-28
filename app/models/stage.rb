class Stage < ActiveRecord::Base
  belongs_to :festival

  has_many :artists

  validates :festival,  presence: true
  validates :name,      presence: true, uniqueness: { scope: :festival }
end
