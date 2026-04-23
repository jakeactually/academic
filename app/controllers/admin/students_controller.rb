module Admin
  class StudentsController < BaseController
    def index
      @students = Student.includes(:career).all
    end

    def create
      @student = Student.new(student_params)
      if @student.save
        redirect_to admin_students_path, notice: "Student was successfully created."
      else
        @students = Student.includes(:career).all
        flash.now[:alert] = "Error creating student: #{@student.errors.full_messages.to_sentence}"
        render :index, status: :unprocessable_entity
      end
    end

    def destroy
      @student = Student.find(params[:id])
      @student.destroy
      redirect_to admin_students_path, notice: "Student was successfully deleted."
    end

    private

    def student_params
      params.require(:student).permit(:name, :email, :career_id, :semester)
    end
  end
end
