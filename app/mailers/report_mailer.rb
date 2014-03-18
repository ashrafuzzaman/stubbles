class ReportMailer < ActionMailer::Base
  layout 'mail/basic'
  default from: "noreply@stubbles.com"

  def sprint_report(email, milestone)
    @milestone = milestone
    attachments.inline['burndown.png'] = @milestone.burn_down_chart.to_blob if @milestone.generate_burn_down?
    mail(to: email, subject: "Sprint report on #{I18n.l(Date.current)} for #{milestone.title}")
  end
end