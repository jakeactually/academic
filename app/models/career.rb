class Career < ApplicationRecord
  has_many :career_subjects, dependent: :destroy
  has_many :subjects, through: :career_subjects

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
