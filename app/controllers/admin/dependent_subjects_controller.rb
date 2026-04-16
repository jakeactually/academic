module Admin
  class DependentSubjectsController < BaseController
    def index
      @subjects = Subject.order(:name)
      @dependent_subjects = DependentSubject.includes(:subject, :dependent_subject).order(created_at: :desc)
    end

    def create
      attrs = params.require(:dependent_subject).permit(:subject_id, :dependent_subject_id)
      DependentSubject.create!(attrs)
      redirect_to admin_dependent_subjects_path, notice: "Subject dependency created."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_dependent_subjects_path, alert: e.record.errors.full_messages.to_sentence
    end
  end
end
