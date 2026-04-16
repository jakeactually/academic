class CourseClass < ApplicationRecord
  belongs_to :teacher_subject
  belongs_to :classroom

  has_one :teacher, through: :teacher_subject
  has_one :subject, through: :teacher_subject

  validates :weekday, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 7 }
  validates :dayhour, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 24 }
  validates :teacher_subject_id, uniqueness: { scope: [ :weekday, :dayhour ] }
end
