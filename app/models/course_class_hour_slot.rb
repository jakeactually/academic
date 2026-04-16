class CourseClassHourSlot < ApplicationRecord
  belongs_to :course_class
  belongs_to :classroom_hour_slot

  validates :classroom_hour_slot_id, uniqueness: { scope: :course_class_id }
end
