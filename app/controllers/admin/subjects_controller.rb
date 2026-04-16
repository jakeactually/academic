module Admin
  class SubjectsController < BaseController
    def index
      @subjects = Subject.order(:name)
    end

    def create
      Subject.create!(name: params.require(:subject).fetch(:name))
      redirect_to admin_subjects_path, notice: "Subject created."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_subjects_path, alert: e.record.errors.full_messages.to_sentence
    end
  end
end
