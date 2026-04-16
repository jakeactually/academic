class CareerSemesterSubject < ApplicationRecord
  belongs_to :career_semester
  belongs_to :subject

  validates :subject_id, uniqueness: { scope: :career_semester_id }
end
