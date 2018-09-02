class TempHumd < ApplicationRecord
  self.table_name = "temp_humd"
  def self.hourly_averages

     mysql_q = "
       SELECT AVG(temperature) as avg_temp, AVG(humidity) as avg_humid
         FROM temp_humd
         GROUP BY HOUR(created_at)
         ORDER BY HOUR(created_at) DESC
         LIMIT 24;"
     ActiveRecord::Base.connection.execute(mysql_q)
   end

   def self.weekly_averages
     mysql_q = "
       SELECT AVG(temperature) as avg_temp, AVG(humidity) as avg_humid
         FROM temp_humd
         GROUP BY DAY(created_at)
         ORDER BY DAY(created_at) DESC
         LIMIT 7; "
     ActiveRecord::Base.connection.execute(mysql_q)
   end

   def self.monthly_averages
     mysql_q = "
       SELECT AVG(temperature) as avg_temp, AVG(humidity) as avg_humid
         FROM temp_humd
         GROUP BY WEEK(created_at)
         ORDER BY WEEK(created_at) DESC
         LIMIT 4; "
     ActiveRecord::Base.connection.execute(mysql_q)
   end
  

end
