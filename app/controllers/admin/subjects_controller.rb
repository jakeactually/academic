module Admin
  class SubjectsController < BaseController
    def index
      @subjects = Subject.order(:name).page(params[:page]).per(20)
    end

    def create
      Subject.create!(name: params.require(:subject).fetch(:name))
      redirect_to admin_subjects_path, notice: "Subject created."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_subjects_path, alert: e.record.errors.full_messages.to_sentence
    end

    def destroy
      subject = Subject.find(params[:id])
      subject.destroy!
      redirect_to admin_subjects_path, notice: "Subject deleted."
    rescue ActiveRecord::RecordNotDestroyed => e
      redirect_to admin_subjects_path, alert: e.record.errors.full_messages.to_sentence
    end
  end
end
