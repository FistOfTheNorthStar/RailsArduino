# Preview all emails at http://localhost:3000/rails/mailers/mold_mailer
class MoldMailerPreview < ActionMailer::Preview
  def warning_email
    MoldMailer.warning_email(76)  
  end
end
