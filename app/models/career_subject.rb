class CareerSubject < ApplicationRecord
  belongs_to :career
  belongs_to :subject

  validates :semester, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :subject_id, uniqueness: { scope: :career_id }
end
