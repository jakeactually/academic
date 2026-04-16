module ApplicationHelper
  def bootstrap_role_badge_class(role)
    case role.to_s
    when "admin" then "text-bg-danger"
    when "teacher" then "text-bg-primary"
    when "student" then "text-bg-success"
    else "text-bg-secondary"
    end
  end
end
