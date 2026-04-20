module Admin
  class CareerSubjectsController < BaseController
    def index
      @careers = Career.order(:name)
      if params[:career_id].present?
        @career = Career.find(params[:career_id])
        @career_subjects = @career.career_subjects.includes(:subject).order(:semester, :created_at)
        @available_subjects = Subject.where.not(id: @career.subjects.select(:id)).order(:name)
      else
        @career_subjects = []
        @available_subjects = []
      end
    end

    def create
      attrs = params.require(:career_subject).permit(:career_id, :subject_id, :semester)
      CareerSubject.create!(attrs)
      redirect_to admin_career_subjects_path(career_id: attrs[:career_id]), notice: "Subject added to career."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_career_subjects_path(career_id: params.dig(:career_id) || params.dig(:career_subject, :career_id)), alert: e.record.errors.full_messages.to_sentence
    end

    def destroy
      assignment = CareerSubject.find(params[:id])
      career_id = assignment.career_id
      assignment.destroy!
      redirect_to admin_career_subjects_path(career_id: career_id), notice: "Career subject assignment deleted."
    rescue ActiveRecord::RecordNotDestroyed => e
      redirect_to admin_career_subjects_path(career_id: params[:career_id]), alert: e.record.errors.full_messages.to_sentence
    end
  end
end
