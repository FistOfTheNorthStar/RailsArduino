class MoldMailer < ActionMailer::Base
  default from: APP_CONFIG['from_email']

  def warning_email(humidity)
    @humd_db = humidity   
    mail(to: APP_CONFIG['mold_email'], subject: 'Mold growth warning')
  end

end
