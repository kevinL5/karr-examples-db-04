class Genre < ActiveRecord::Base
  has_and_belongs_to_many :festivals

  validates :name, presence: true, uniqueness: true
end
