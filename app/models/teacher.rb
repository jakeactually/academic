class Teacher < ApplicationRecord
  has_many :teacher_subjects, dependent: :destroy
  has_many :subjects, through: :teacher_subjects

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  after_create :create_user_account

  private

  def create_user_account
    User.find_or_create_by!(email: email) do |user|
      user.password = "password"
      user.role = :teacher
    end
  end
end
