module Admin
  class CourseClassesController < BaseController
    def index
      @teachers = Teacher.order(:name)
      @subjects = Subject.order(:name)
      @classrooms = Classroom.order(:name)
      @course_classes = CourseClass.includes(:teacher, :subject, :classroom).order(:weekday, :dayhour)
    end

    def create
      attrs = params.require(:course_class).permit(:teacher_id, :subject_id, :classroom_id, :weekday, :dayhour)
      CourseClass.create!(attrs)
      redirect_to admin_course_classes_path, notice: "Class created."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_course_classes_path, alert: e.record.errors.full_messages.to_sentence
    end

    def destroy
      course_class = CourseClass.find(params[:id])
      course_class.destroy!
      redirect_to admin_course_classes_path, notice: "Class deleted."
    rescue ActiveRecord::RecordNotDestroyed => e
      redirect_to admin_course_classes_path, alert: e.record.errors.full_messages.to_sentence
    end
  end
end
