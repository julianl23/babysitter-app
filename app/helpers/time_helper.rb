module TimeHelper
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

  # Helper to handle times from datetime_select
  def parse_datetime_date(type, resource)
    year = resource["#{type}(1i)"].to_i
    month = resource["#{type}(2i)"].to_i
    day = resource["#{type}(3i)"].to_i
    hour = resource["#{type}(4i)"].to_i
    minute = resource["#{type}(5i)"].to_i
    DateTime.new(year, month, day, hour, minute)
  end
end