class StudentSubject < ApplicationRecord
  belongs_to :student
  belongs_to :subject

  validates :student_id, uniqueness: { scope: :subject_id, message: "already has this subject" }
end
