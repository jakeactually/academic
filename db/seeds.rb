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

careers = [
  "Computer Science",
  "Business Administration",
  "Mechanical Engineering",
  "Civil Engineering",
  "Electrical Engineering",
  "Industrial Engineering",
  "Chemical Engineering",
  "Biomedical Engineering",
  "Architecture",
  "Law",
  "Medicine",
  "Nursing",
  "Psychology",
  "Economics",
  "Accounting",
  "Marketing",
  "International Relations",
  "Mathematics",
  "Physics",
  "Data Science"
]

careers.each do |name|
  Career.find_or_create_by!(name:)
end

subjects = [
  "Algorithms",
  "Databases",
  "Linear Algebra",
  "Microeconomics",
  "Calculus I",
  "Calculus II",
  "Statistics",
  "Physics I",
  "Physics II",
  "Programming I",
  "Programming II",
  "Operating Systems",
  "Computer Networks",
  "Software Engineering",
  "Digital Logic",
  "Marketing Fundamentals",
  "Financial Accounting",
  "Organizational Behavior",
  "Machine Learning",
  "Ethics",
  "Project Management"
]

subjects.each do |name|
  Subject.find_or_create_by!(name:)
end

teachers = [
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
  { name: "Prof. Paul Erdos", email: "paul.erdos@example.com" },
  { name: "Prof. Carl Gauss", email: "carl.gauss@example.com" },
  { name: "Prof. Sofia Kovalevskaya", email: "sofia.kovalevskaya@example.com" },
  { name: "Prof. Amartya Sen", email: "amartya.sen@example.com" },
  { name: "Prof. Elinor Ostrom", email: "elinor.ostrom@example.com" },
  { name: "Prof. Peter Drucker", email: "peter.drucker@example.com" },
  { name: "Prof. Michael Porter", email: "michael.porter@example.com" },
  { name: "Prof. Rosalind Franklin", email: "rosalind.franklin@example.com" },
  { name: "Prof. Marie Curie", email: "marie.curie@example.com" }
]

teachers.each do |attrs|
  Teacher.find_or_create_by!(email: attrs[:email]) do |teacher|
    teacher.name = attrs[:name]
  end
end

classrooms = [
  "Room A101",
  "Room A102",
  "Room A103",
  "Room A104",
  "Room B201",
  "Room B202",
  "Room B203",
  "Room B204",
  "Room C301",
  "Room C302",
  "Room C303",
  "Room C304",
  "Lab L1",
  "Lab L2",
  "Lab L3",
  "Lab L4",
  "Auditorium 1",
  "Auditorium 2",
  "Seminar Hall 1",
  "Seminar Hall 2"
]

classrooms.each do |name|
  Classroom.find_or_create_by!(name:)
end
