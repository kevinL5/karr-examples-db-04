class Organizer < ActiveRecord::Base
  belongs_to :festival

  validates :festival,  presence:     true
  validates :name,      presence:     true, uniqueness: true
  validates :email,     presence:     true, format: { with: /\A.*@.*\..*\z/ }
  validates :password,  confirmation: true, length: { minimum: 6 }
end
