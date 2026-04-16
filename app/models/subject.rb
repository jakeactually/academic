class Subject < ApplicationRecord
  has_many :career_subjects, dependent: :destroy
  has_many :careers, through: :career_subjects

  has_many :dependencies, class_name: "DependentSubject", dependent: :destroy
  has_many :dependent_on_subjects, through: :dependencies, source: :dependent_subject

  has_many :reverse_dependencies, class_name: "DependentSubject", foreign_key: :dependent_subject_id, inverse_of: :dependent_subject, dependent: :destroy
  has_many :required_for_subjects, through: :reverse_dependencies, source: :subject

  has_many :teacher_subjects, dependent: :destroy
  has_many :teachers, through: :teacher_subjects

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
