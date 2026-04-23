module Admin
  class CourseClassesController < BaseController
    def index
      @teacher_subjects = TeacherSubject.includes(:teacher, subject: :careers).order(:created_at)
      @careers = Career.order(:name)
      @career_ts_map = {}
      @careers.each do |c|
        @career_ts_map[c.id] = @teacher_subjects.select { |ts| ts.subject.career_ids.include?(c.id) }.map(&:id)
      end
      @classrooms = Classroom.order(:name)
      @selected_classroom_id = params[:classroom_id] || @classrooms.first&.id
      @selected_classroom = @classrooms.find(@selected_classroom_id)
      @course_classes = CourseClass.includes(:classroom, teacher_subject: [:teacher, :subject])
                                   .where(classroom_id: @selected_classroom_id)
                                   .order(:weekday, :dayhour)
                                   .group_by { |cc| [cc.weekday, cc.dayhour] }
    end

    def create
      attrs = params.require(:course_class).permit(:teacher_subject_id, :classroom_id, :weekday, :dayhour)
      CourseClass.create!(attrs)
      redirect_to admin_course_classes_path(classroom_id: attrs[:classroom_id]), notice: "Class created."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_course_classes_path(classroom_id: attrs[:classroom_id]), alert: e.record.errors.full_messages.to_sentence
    end

    def destroy
      course_class = CourseClass.find(params[:id])
      classroom_id = course_class.classroom_id
      course_class.destroy!
      redirect_to admin_course_classes_path(classroom_id: classroom_id), notice: "Class deleted."
    rescue ActiveRecord::RecordNotDestroyed => e
      redirect_to admin_course_classes_path, alert: e.record.errors.full_messages.to_sentence
    end
  end
end
