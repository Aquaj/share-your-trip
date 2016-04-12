class ApplicationMailer < ActionMailer::Base
  default from: "contact@shareyourtrip.fr"
  add_template_helper(ApplicationHelper)
  add_template_helper(RoadmapsHelper)
  layout 'mailer'
end
