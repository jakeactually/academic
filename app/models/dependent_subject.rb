class DependentSubject < ApplicationRecord
  belongs_to :subject
  belongs_to :dependent_subject, class_name: "Subject"

  validates :dependent_subject_id, uniqueness: { scope: :subject_id }
  validate :cannot_depend_on_self

  private

  def cannot_depend_on_self
    return unless subject_id.present? && dependent_subject_id.present?
    return unless subject_id == dependent_subject_id

    errors.add(:dependent_subject_id, "must be a different subject")
  end
end
