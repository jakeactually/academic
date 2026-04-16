class Teacher < ApplicationRecord
  has_many :teacher_subjects, dependent: :destroy
  has_many :subjects, through: :teacher_subjects

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
