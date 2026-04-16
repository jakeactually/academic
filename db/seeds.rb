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
