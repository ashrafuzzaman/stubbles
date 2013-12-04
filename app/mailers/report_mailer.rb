class ReportMailer < ActionMailer::Base
  layout 'mail/basic'
  default from: "noreply@stubbles.com"

  def sprint_report(email, milestone)
    @milestone = milestone
    mail(to: email, subject: "Sprint report on #{I18n.l(Date.current)}")
  end
end