module Admin
  class CourseClassesController < BaseController
    def index
      @teachers = Teacher.order(:name)
      @subjects = Subject.order(:name)
      @classroom_hour_slots = ClassroomHourSlot.includes(:classroom).order(:label)
      @course_classes = CourseClass.includes(:teacher, :subject, :classroom_hour_slots).order(created_at: :desc)
    end

    def create
      attrs = params.require(:course_class).permit(:teacher_id, :subject_id, classroom_hour_slot_ids: [])
      slot_ids = attrs.delete(:classroom_hour_slot_ids).to_a.reject(&:blank?)

      course_class = CourseClass.create!(attrs)
      course_class.classroom_hour_slot_ids = slot_ids

      redirect_to admin_course_classes_path, notice: "Class created."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_course_classes_path, alert: e.record.errors.full_messages.to_sentence
    end
  end
end
