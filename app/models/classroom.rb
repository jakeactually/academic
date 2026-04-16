class Classroom < ApplicationRecord
  has_many :classroom_hour_slots, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
