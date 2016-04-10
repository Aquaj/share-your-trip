class ApplicationMailer < ActionMailer::Base
  default from: "contact@share-your-trip.com"
  add_template_helper(ApplicationHelper)
  layout 'mailer'
end
