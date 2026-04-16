class Teacher < ApplicationRecord
  has_many :course_classes, dependent: :restrict_with_error

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
