module Admin
  class TeacherSubjectsController < BaseController
    def index
      @teachers = Teacher.order(:name)
      @subjects = Subject.order(:name)
      @teacher_subjects = TeacherSubject.includes(:teacher, :subject).order(:created_at)
    end

    def create
      attrs = params.require(:teacher_subject).permit(:teacher_id, :subject_id)
      TeacherSubject.create!(attrs)
      redirect_to admin_teacher_subjects_path, notice: "Teacher-subject link created."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_teacher_subjects_path, alert: e.record.errors.full_messages.to_sentence
    end

    def destroy
      link = TeacherSubject.find(params[:id])
      link.destroy!
      redirect_to admin_teacher_subjects_path, notice: "Teacher-subject link deleted."
    rescue ActiveRecord::RecordNotDestroyed => e
      redirect_to admin_teacher_subjects_path, alert: e.record.errors.full_messages.to_sentence
    end
  end
end
