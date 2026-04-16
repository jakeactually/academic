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

    def destroy
      teacher = Teacher.find(params[:id])
      teacher.destroy!
      redirect_to admin_teachers_path, notice: "Teacher deleted."
    rescue ActiveRecord::RecordNotDestroyed => e
      redirect_to admin_teachers_path, alert: e.record.errors.full_messages.to_sentence
    end
  end
end
