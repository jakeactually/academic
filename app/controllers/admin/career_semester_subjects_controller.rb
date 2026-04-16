module Admin
  class CareerSemesterSubjectsController < BaseController
    def index
      @subjects = Subject.order(:name)
      @career_semesters = CareerSemester.includes(:career).order(:name)
      @career_semester_subjects = CareerSemesterSubject.includes(:subject, career_semester: :career).order(created_at: :desc)
    end

    def create
      attrs = params.require(:career_semester_subject).permit(:career_semester_id, :subject_id)
      CareerSemesterSubject.create!(attrs)
      redirect_to admin_career_semester_subjects_path, notice: "Subject added to semester."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_career_semester_subjects_path, alert: e.record.errors.full_messages.to_sentence
    end

    def destroy
      assignment = CareerSemesterSubject.find(params[:id])
      assignment.destroy!
      redirect_to admin_career_semester_subjects_path, notice: "Semester subject assignment deleted."
    rescue ActiveRecord::RecordNotDestroyed => e
      redirect_to admin_career_semester_subjects_path, alert: e.record.errors.full_messages.to_sentence
    end
  end
end
