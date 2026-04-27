class DashboardController < ApplicationController
  def index
    if current_user.student?
      @student = Student.find_by(email: current_user.email)
      if @student
        @taken_classes = @student.course_classes.includes(teacher_subject: [:teacher, { subject: :careers }], classroom: [])
        @schedule_classes = @taken_classes.group_by { |c| [c.weekday, c.dayhour] }
        
        subject_ids = CareerSubject.where(career_id: @student.career_id, semester: @student.semester).select(:subject_id)
        
        @available_classes = CourseClass.includes(teacher_subject: [:subject, :teacher], classroom: [])
                                        .joins(:teacher_subject)
                                        .where(teacher_subjects: { subject_id: subject_ids })
        if @taken_classes.any?
          @available_classes = @available_classes.where.not(id: @taken_classes.select(:id))
        end
      end
    elsif current_user.teacher?
      @teacher = Teacher.find_by(email: current_user.email)
      if @teacher
        @assigned_classes = CourseClass.includes(teacher_subject: { subject: :careers }, classroom: [])
                                       .joins(:teacher_subject)
                                       .where(teacher_subjects: { teacher_id: @teacher.id })
        @schedule_classes = @assigned_classes.group_by { |c| [c.weekday, c.dayhour] }
      end
    end
  end

  def enroll
    @student = Student.find_by(email: current_user.email)
    course_class = CourseClass.find(params[:course_class_id])
    
    if @student && current_user.student?
      StudentCourseClass.find_or_create_by!(student: @student, course_class: course_class, attending: true)
      redirect_to root_path, notice: "Successfully enrolled in class."
    else
      redirect_to root_path, alert: "Not authorized."
    end
  end

  def drop
    @student = Student.find_by(email: current_user.email)
    course_class = CourseClass.find(params[:course_class_id])
    
    if @student && current_user.student?
      enrollment = StudentCourseClass.find_by(student: @student, course_class: course_class)
      enrollment&.destroy
      redirect_to root_path, notice: "Successfully dropped the class."
    else
      redirect_to root_path, alert: "Not authorized."
    end
  end
end
