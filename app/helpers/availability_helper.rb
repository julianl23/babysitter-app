module AvailabilityHelper
  # Helper to handle times from datetime_select
  # def parse_availability_date(type, availability)
  #   year = availability["#{type}(1i)"].to_i
  #   month = availability["#{type}(2i)"].to_i
  #   day = availability["#{type}(3i)"].to_i
  #   hour = availability["#{type}(4i)"].to_i
  #   minute = availability["#{type}(5i)"].to_i
  #   DateTime.new(year, month, day, hour, minute)
  # end

  def parse_availability_date(date_string)
    time = Time.at(date_string.to_i / 1000)
    time.to_datetime
  end
end