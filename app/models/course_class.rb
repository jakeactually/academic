class CourseClass < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject

  validates :weekday, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 7 }
  validates :dayhour, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 24 }
  validates :teacher_id, uniqueness: { scope: [ :weekday, :dayhour ] }
end
