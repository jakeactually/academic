class Student < ApplicationRecord
  belongs_to :career
  has_many :student_subjects, dependent: :destroy
  has_many :subjects, through: :student_subjects
  has_many :student_course_classes, dependent: :destroy
  has_many :course_classes, through: :student_course_classes

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :semester, presence: true, numericality: { greater_than: 0 }
end
