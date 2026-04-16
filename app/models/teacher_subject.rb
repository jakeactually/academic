class TeacherSubject < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject

  has_many :course_classes, dependent: :restrict_with_error

  validates :subject_id, uniqueness: { scope: :teacher_id }

  def display_name
    "#{teacher.name} - #{subject.name}"
  end
end
