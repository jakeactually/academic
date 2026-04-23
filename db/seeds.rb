# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

demo_password = "password"

[
  { email: "admin@example.com", role: :admin },
  { email: "teacher@example.com", role: :teacher },
  { email: "student@example.com", role: :student }
].each do |attrs|
  user = User.find_or_initialize_by(email: attrs[:email])
  user.password = demo_password
  user.role = attrs[:role]
  user.save!
end

curriculums = {
  "Business Management" => {
    1 => ["Introduction to Management", "Business Mathematics"],
    2 => ["Organizational Behavior", "Business Communication", "Accounting I"],
    3 => ["Operations Management", "Human Resource Management", "Marketing Principles"],
    4 => ["Business Law", "Financial Management Fundamentals", "Supply Chain Management"],
    5 => ["Strategic Management", "Innovation and Entrepreneurship", "International Business"],
    6 => ["Digital Business Transformation", "Project Management", "Electronics Basics"],
    7 => ["Corporate Governance", "Leadership Development", "Public Relations"],
    8 => ["Business Capstone Project", "Managerial Economics"]
  },
  "Computer Science" => {
    1 => ["Introduction to Programming", "Discrete Mathematics"],
    2 => ["Data Structures", "Computer Architecture", "Calculus I"],
    3 => ["Algorithms", "Database Systems", "Operating Systems"],
    4 => ["Software Engineering", "Computer Networks", "Theory of Computation"],
    5 => ["Artificial Intelligence", "Web Development", "Cybersecurity Basics"],
    6 => ["Machine Learning", "Cloud Computing", "Mobile App Development"],
    7 => ["Distributed Systems", "Parallel Programming", "Software Quality Assurance"],
    8 => ["CS Capstone Project", "Professional Ethics"]
  },
  "Economics" => {
    1 => ["Principles of Microeconomics", "Economic History"],
    2 => ["Principles of Macroeconomics", "Mathematical Economics"],
    3 => ["Intermediate Microeconomics", "Intermediate Macroeconomics", "Statistics"],
    4 => ["Econometrics I", "Development Economics", "Monetary Policy"],
    5 => ["Econometrics II", "International Trade", "Public Finance"],
    6 => ["Game Theory", "Behavioral Economics", "Labor Economics"],
    7 => ["Environmental Economics", "Economic Policy Analysis", "Industrial Organization"],
    8 => ["Economics Thesis", "History of Economic Thought"]
  },
  "Finance" => {
    1 => ["Introduction to Finance", "Financial Accounting I"],
    2 => ["Financial Accounting II", "Business Finance", "Quantitative Methods in Finance"],
    3 => ["Investment Analysis", "Financial Markets and Institutions", "Corporate Finance"],
    4 => ["Portfolio Management", "Derivatives and Risk Management", "Financial Statement Analysis"],
    5 => ["Fixed Income Securities", "International Finance", "Wealth Management"],
    6 => ["Fintech Innovation", "Real Estate Finance", "Mergers and Acquisitions"],
    7 => ["Behavioral Finance", "Taxation and Financial Planning", "Advanced Corporate Finance"],
    8 => ["Finance Seminar", "Professional Ethics"]
  },
  "Graphic Design" => {
    1 => ["Drawing and Composition", "Color Theory"],
    2 => ["Typography I", "Introduction to Digital Design", "Aesthetics and Design History"],
    3 => ["Typography II", "Graphic Design Studio I", "Illustration Basics"],
    4 => ["Brand Identity Design", "Graphic Design Studio II", "Motion Graphics"],
    5 => ["Web Design Fundamentals", "Editorial Design", "Package Design"],
    6 => ["UI/UX Design", "Advanced Motion Graphics", "Product Photography"],
    7 => ["Environmental Design", "Design Research Methods", "Advertising Design"],
    8 => ["Design Portfolio", "Professional Practice in Design"]
  },
  "Marketing" => {
    1 => ["Marketing Principles", "Consumer Psychology"],
    2 => ["Digital Marketing Basics", "Market Research Methods", "Brand Management"],
    3 => ["Advertising and Promotion", "Sales Management", "Service Marketing"],
    4 => ["Social Media Marketing", "Content Strategy", "Strategic Marketing"],
    5 => ["Data Analytics in Marketing", "PR and Corporate Communications", "E-commerce Strategy"],
    6 => ["Influencer Marketing", "Global Marketing", "Pricing Strategy"],
    7 => ["B2B Marketing", "Marketing Ethics and Law", "Campaign Planning"],
    8 => ["Marketing Capstone", "Customer Relationship Management"]
  }
}

# Ensure at least 6 subjects per semester for each career
curriculums.each do |career_name, semesters|
  semesters.each do |semester_number, subject_names|
    current_count = subject_names.size
    (6 - current_count).times do |i|
      subject_names << "#{career_name} Elective #{current_count + i + 1} (S#{semester_number})"
    end
  end
end

puts "Creating careers..."
curriculums.each_key do |name|
  Career.find_or_create_by!(name: name)
end

puts "Creating teachers..."
teachers_data = [
  { name: "Prof. Ada Lovelace", email: "ada.lovelace@example.com" },
  { name: "Prof. Alan Turing", email: "alan.turing@example.com" },
  { name: "Prof. Grace Hopper", email: "grace.hopper@example.com" },
  { name: "Prof. Edsger Dijkstra", email: "edsger.dijkstra@example.com" },
  { name: "Prof. Donald Knuth", email: "donald.knuth@example.com" },
  { name: "Prof. Barbara Liskov", email: "barbara.liskov@example.com" },
  { name: "Prof. Claude Shannon", email: "claude.shannon@example.com" },
  { name: "Prof. John von Neumann", email: "john.vonneumann@example.com" },
  { name: "Prof. Katherine Johnson", email: "katherine.johnson@example.com" },
  { name: "Prof. Emmy Noether", email: "emmy.noether@example.com" },
  { name: "Prof. Richard Feynman", email: "richard.feynman@example.com" },
  { name: "Prof. Paul Erdos", email: "paul.erdos@example.com" }
]

teachers = teachers_data.map do |attrs|
  Teacher.find_or_create_by!(email: attrs[:email]) do |teacher|
    teacher.name = attrs[:name]
  end
end

puts "Creating subjects and linking them to careers and teachers..."
curriculums.each do |career_name, semesters|
  career = Career.find_by!(name: career_name)

  semesters.each do |semester_number, subject_names|
    subject_names.each do |subject_name|
      subject = Subject.find_or_create_by!(name: subject_name)

      # Link subject to career and semester
      CareerSubject.find_or_create_by!(career: career, subject: subject, semester: semester_number)

      # Link subject to a search teacher (randomly for variety, but stable)
      # We use the subject name length to pick a teacher so it's idempotent
      teacher_index = subject_name.length % teachers.size
      teacher = teachers[teacher_index]
      TeacherSubject.find_or_create_by!(teacher: teacher, subject: subject)

      # Optionally add a second teacher for some subjects to satisfy "a teacher teaches many subjects"
      # and "some subjects might have multiple teachers" (though the requirement was simpler)
      if subject_name.length.even?
        second_teacher_index = (subject_name.length * 2) % teachers.size
        second_teacher = teachers[second_teacher_index]
        TeacherSubject.find_or_create_by!(teacher: second_teacher, subject: subject)
      end
    end
  end
end

# Teachers were created above in the curriculum loop to ensure availability for assignments.

classrooms = [
  "Room A101",
  "Room A102",
  "Room B201",
  "Room B202",
  "Room C301",
  "Room C302",
  "Lab L1",
  "Lab L2",
  "Lab L3",
  "Auditorium 1",
  "Seminar Hall 1"
]

classrooms.each do |name|
  Classroom.find_or_create_by!(name:)
end

puts "Creating students..."
cs_career = Career.find_by(name: "Computer Science") || Career.first

if cs_career
  students_data = [
    { name: "Alice Smith", email: "student@example.com", semester: 1 },
    { name: "Bob Johnson", email: "bob.johnson@example.com", semester: 2 },
    { name: "Charlie Brown", email: "charlie.brown@example.com", semester: 3 },
    { name: "Diana Prince", email: "diana.prince@example.com", semester: 4 }
  ]

  students_data.each do |attrs|
    Student.find_or_create_by!(email: attrs[:email]) do |student|
      student.name = attrs[:name]
      student.career = cs_career
      student.semester = attrs[:semester]
    end
  end
end

puts "Ensuring every teacher-subject has at least one course class..."
classrooms_list = Classroom.all.to_a
if classrooms_list.any?
  TeacherSubject.find_each do |ts|
    next if ts.course_classes.exists?
    
    created = false
    attempts = 0
    while !created && attempts < 200
      attempts += 1
      classroom = classrooms_list.sample
      day = rand(1..6)
      hour = rand(7..21)

      next if CourseClass.exists?(classroom: classroom, weekday: day, dayhour: hour)
      next if CourseClass.exists?(teacher_subject: ts, weekday: day, dayhour: hour)
      
      begin
        CourseClass.create!(
          teacher_subject: ts,
          classroom: classroom,
          weekday: day,
          dayhour: hour
        )
        created = true
      rescue ActiveRecord::RecordInvalid
        next
      end
    end
  end
  puts "Finished ensuring all teacher-subjects have classes."
end
