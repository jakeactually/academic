class CareerSemester < ApplicationRecord
  belongs_to :career

  has_many :career_semester_subjects, dependent: :destroy
  has_many :subjects, through: :career_semester_subjects

  validates :name, presence: true, uniqueness: { scope: :career_id, case_sensitive: false }
end
