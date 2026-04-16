module Admin
  class TeachersController < BaseController
    def index
      @teachers = Teacher.order(:name)
    end

    def create
      attrs = params.require(:teacher).permit(:name, :email)
      Teacher.create!(attrs)
      redirect_to admin_teachers_path, notice: "Teacher created."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_teachers_path, alert: e.record.errors.full_messages.to_sentence
    end
  end
end
