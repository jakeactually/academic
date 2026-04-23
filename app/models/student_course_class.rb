class StudentCourseClass < ApplicationRecord
  belongs_to :student
  belongs_to :course_class

  validates :student_id, uniqueness: { scope: :course_class_id, message: "is already in this class" }
end
