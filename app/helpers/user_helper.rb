module UserHelper
  def format_hour(hour)
    if [0, 12].include?(hour)
      suffix = hour.zero? ? 'AM' : 'PM'
      formatted_hour = 12
    elsif hour >= 12 && hour < 24
      suffix = 'PM'
      formatted_hour = hour - 12
    else
      suffix = 'AM'
      formatted_hour = hour
    end
    "#{formatted_hour}:00 #{suffix}"
  end

  def format_week_of_string(days_of_week)
    first_day = days_of_week.first
    last_day = days_of_week.last
    "Week of #{first_day.strftime '%B %-d, %Y'} to #{last_day.strftime '%B %-d, %Y'}"
  end
end