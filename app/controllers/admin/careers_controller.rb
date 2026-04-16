module Admin
  class CareersController < BaseController
    def index
      @careers = Career.order(:name)
    end

    def create
      Career.create!(name: params.require(:career).fetch(:name))
      redirect_to admin_careers_path, notice: "Career created."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_careers_path, alert: e.record.errors.full_messages.to_sentence
    end
  end
end
