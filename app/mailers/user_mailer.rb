class UserMailer < ActionMailer::Base
  default from: "group360worldwide@gmail.com",
          to: Proc.new { User.where(role: 5).pluck(:email) }

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.notify_approver.subject
  #
  def notify_approver(item)
    @item = item
    @url = case @item.class.name
    when 'Program'
      program_url(@item)
    when 'Event'
      event_url(@item)
    end
    mail(subject: "#{@item.name} may need your approval")
  end
end
