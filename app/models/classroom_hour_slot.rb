class ClassroomHourSlot < ApplicationRecord
  belongs_to :classroom

  has_many :course_class_hour_slots, dependent: :destroy
  has_many :course_classes, through: :course_class_hour_slots

  validates :label, presence: true, uniqueness: { scope: :classroom_id, case_sensitive: false }
end
