class HomeController < ApplicationController
  def index
    #normally not the best way to achieve this, but since only one user at a time
    t24h_temp = TempHumd.hourly_averages
    week_temp = TempHumd.weekly_averages
    month_temp = TempHumd.monthly_averages

    @t24 = helpers.create_payload(t24h_temp, 24)
    @week = helpers.create_payload(week_temp, 7)
    @month = helpers.create_payload(month_temp, 4)
     
  end
end
