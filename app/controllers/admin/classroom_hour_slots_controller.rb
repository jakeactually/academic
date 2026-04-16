module Admin
  class ClassroomHourSlotsController < BaseController
    def index
      @classrooms = Classroom.order(:name)
      @classroom_hour_slots = ClassroomHourSlot.includes(:classroom).order(:label)
    end

    def create
      attrs = params.require(:classroom_hour_slot).permit(:classroom_id, :label)
      ClassroomHourSlot.create!(attrs)
      redirect_to admin_classroom_hour_slots_path, notice: "Classroom hour slot created."
    rescue ActiveRecord::RecordInvalid => e
      redirect_to admin_classroom_hour_slots_path, alert: e.record.errors.full_messages.to_sentence
    end

    def destroy
      slot = ClassroomHourSlot.find(params[:id])
      slot.destroy!
      redirect_to admin_classroom_hour_slots_path, notice: "Classroom hour slot deleted."
    rescue ActiveRecord::RecordNotDestroyed => e
      redirect_to admin_classroom_hour_slots_path, alert: e.record.errors.full_messages.to_sentence
    end
  end
end
