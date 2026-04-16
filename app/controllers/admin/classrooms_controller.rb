module Admin
  class ClassroomsController < BaseController
    def index
      @classrooms = Classroom.order(:name)
    end

    def create
      Classroom.create!(name: params.require(:classroom).fetch(:name))
      redirect_to admin_classrooms_path, notice: "Classroom created."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_classrooms_path, alert: e.record.errors.full_messages.to_sentence
    end
  end
end
