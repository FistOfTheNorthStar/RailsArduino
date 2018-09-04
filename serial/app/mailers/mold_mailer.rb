class MoldMailer < ApplicationMailer
  default from: APP_CONFIG['from_email']

  def warning_email
    mysql_q = "
      SELECT AVG(humidity) as avg_humid
        FROM temp_humd
        GROUP BY DAY(created_at)
        ORDER BY DAY(created_at) DESC
        LIMIT 1; "
    humd_temp = ActiveRecord::Base.connection.execute(mysql_q)
    @humd_db = 0
    p humd_temp
    if humd_temp.present?
      @humd_db = humd_temp.first
    else
      return
    end
    if @humd_db < 75
      return
    end
      
    mail(to: APP_CONFIG['mold_email'], subject: 'Mold growth warning')
  end

end
