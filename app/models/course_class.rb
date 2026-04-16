class CourseClass < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject

  has_many :course_class_hour_slots, dependent: :destroy
  has_many :classroom_hour_slots, through: :course_class_hour_slots
end
