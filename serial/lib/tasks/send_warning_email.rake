desc "Send a warning email"
task send_warning: :environment do
  mysql_q = "
    SELECT AVG(humidity) as avg_humid
    FROM temp_humd
    GROUP BY DAY(created_at)
    ORDER BY DAY(created_at) DESC
    LIMIT 1; "
  humd_temp = ActiveRecord::Base.connection.execute(mysql_q).first
  humidity = 0
  if humd_temp.blank?
    return
  else
    humidity = humd_temp[0]
  end
  if humidity < 75
    return
  end
  MoldMailer.warning_email(humidity)
   
end
