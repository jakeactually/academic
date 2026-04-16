module Admin
  class CatalogController < ApplicationController
    before_action :require_admin
    before_action :load_collections, only: :index

    def index; end

    def create_career
      Career.create!(name: params.require(:career).fetch(:name))
      redirect_to admin_root_path, notice: "Career created."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_root_path, alert: e.record.errors.full_messages.to_sentence
    end

    def create_career_semester
      attrs = params.require(:career_semester).permit(:career_id, :name)
      CareerSemester.create!(attrs)
      redirect_to admin_root_path, notice: "Career semester created."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_root_path, alert: e.record.errors.full_messages.to_sentence
    end

    def create_subject
      Subject.create!(name: params.require(:subject).fetch(:name))
      redirect_to admin_root_path, notice: "Subject created."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_root_path, alert: e.record.errors.full_messages.to_sentence
    end

    def create_teacher
      attrs = params.require(:teacher).permit(:name, :email)
      Teacher.create!(attrs)
      redirect_to admin_root_path, notice: "Teacher created."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_root_path, alert: e.record.errors.full_messages.to_sentence
    end

    def create_classroom
      Classroom.create!(name: params.require(:classroom).fetch(:name))
      redirect_to admin_root_path, notice: "Classroom created."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_root_path, alert: e.record.errors.full_messages.to_sentence
    end

    def create_classroom_hour_slot
      attrs = params.require(:classroom_hour_slot).permit(:classroom_id, :label)
      ClassroomHourSlot.create!(attrs)
      redirect_to admin_root_path, notice: "Classroom hour slot created."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_root_path, alert: e.record.errors.full_messages.to_sentence
    end

    def create_dependent_subject
      attrs = params.require(:dependent_subject).permit(:subject_id, :dependent_subject_id)
      DependentSubject.create!(attrs)
      redirect_to admin_root_path, notice: "Subject dependency created."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_root_path, alert: e.record.errors.full_messages.to_sentence
    end

    def create_career_semester_subject
      attrs = params.require(:career_semester_subject).permit(:career_semester_id, :subject_id)
      CareerSemesterSubject.create!(attrs)
      redirect_to admin_root_path, notice: "Subject added to semester."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_root_path, alert: e.record.errors.full_messages.to_sentence
    end

    def create_course_class
      attrs = params.require(:course_class).permit(:teacher_id, :subject_id, classroom_hour_slot_ids: [])
      slot_ids = attrs.delete(:classroom_hour_slot_ids).to_a.reject(&:blank?)

      course_class = CourseClass.create!(attrs)
      course_class.classroom_hour_slot_ids = slot_ids

      redirect_to admin_root_path, notice: "Class created."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_root_path, alert: e.record.errors.full_messages.to_sentence
    end

    private

    def load_collections
      @careers = Career.order(:name)
      @career_semesters = CareerSemester.includes(:career).order(:name)
      @subjects = Subject.order(:name)
      @teachers = Teacher.order(:name)
      @classrooms = Classroom.order(:name)
      @classroom_hour_slots = ClassroomHourSlot.includes(:classroom).order(:label)
      @course_classes = CourseClass.includes(:teacher, :subject, :classroom_hour_slots).order(created_at: :desc)
      @dependent_subjects = DependentSubject.includes(:subject, :dependent_subject).order(created_at: :desc)
    end
  end
end
