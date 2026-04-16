module Admin
  class CareerSubjectsController < BaseController
    def index
      @careers = Career.order(:name)
      @subjects = Subject.order(:name)
      @career_subjects = CareerSubject.includes(:career, :subject).order(:semester, :created_at)
    end

    def create
      attrs = params.require(:career_subject).permit(:career_id, :subject_id, :semester)
      CareerSubject.create!(attrs)
      redirect_to admin_career_subjects_path, notice: "Subject added to career."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_career_subjects_path, alert: e.record.errors.full_messages.to_sentence
    end

    def destroy
      assignment = CareerSubject.find(params[:id])
      assignment.destroy!
      redirect_to admin_career_subjects_path, notice: "Career subject assignment deleted."
    rescue ActiveRecord::RecordNotDestroyed => e
      redirect_to admin_career_subjects_path, alert: e.record.errors.full_messages.to_sentence
    end
  end
end
