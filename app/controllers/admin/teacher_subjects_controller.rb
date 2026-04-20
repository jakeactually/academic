module Admin
  class TeacherSubjectsController < BaseController
    def index
      @teachers = Teacher.order(:name)
      if params[:teacher_id].present?
        @teacher = Teacher.find(params[:teacher_id])
        @teacher_subjects = @teacher.teacher_subjects.includes(:subject).order(:created_at)
        @available_subjects = Subject.where.not(id: @teacher.subjects.select(:id)).order(:name)
      else
        @teacher_subjects = []
        @available_subjects = []
      end
    end

    def create
      attrs = params.require(:teacher_subject).permit(:teacher_id, :subject_id)
      TeacherSubject.create!(attrs)
      redirect_to admin_teacher_subjects_path(teacher_id: attrs[:teacher_id]), notice: "Subject linked to teacher."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_teacher_subjects_path(teacher_id: params.dig(:teacher_id) || params.dig(:teacher_subject, :teacher_id)), alert: e.record.errors.full_messages.to_sentence
    end

    def destroy
      link = TeacherSubject.find(params[:id])
      teacher_id = link.teacher_id
      link.destroy!
      redirect_to admin_teacher_subjects_path(teacher_id: teacher_id), notice: "Teacher-subject link deleted."
    rescue ActiveRecord::RecordNotDestroyed => e
      redirect_to admin_teacher_subjects_path(teacher_id: params[:teacher_id]), alert: e.record.errors.full_messages.to_sentence
    end
  end
end
