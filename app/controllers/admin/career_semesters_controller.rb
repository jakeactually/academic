module Admin
  class CareerSemestersController < BaseController
    def index
      @careers = Career.order(:name)
      @career_semesters = CareerSemester.includes(:career).order(:name)
    end

    def create
      attrs = params.require(:career_semester).permit(:career_id, :name)
      CareerSemester.create!(attrs)
      redirect_to admin_career_semesters_path, notice: "Career semester created."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_career_semesters_path, alert: e.record.errors.full_messages.to_sentence
    end

    def destroy
      semester = CareerSemester.find(params[:id])
      semester.destroy!
      redirect_to admin_career_semesters_path, notice: "Career semester deleted."
    rescue ActiveRecord::RecordNotDestroyed => e
      redirect_to admin_career_semesters_path, alert: e.record.errors.full_messages.to_sentence
    end
  end
end
