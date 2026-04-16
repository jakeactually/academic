class Career < ApplicationRecord
  has_many :career_semesters, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
