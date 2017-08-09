module AvailabilityHelper
  def parse_availability_date(type, availability)
    year = availability["#{type}(1i)"].to_i
    month = availability["#{type}(2i)"].to_i
    day = availability["#{type}(3i)"].to_i
    hour = availability["#{type}(4i)"].to_i
    minute = availability["#{type}(5i)"].to_i
    DateTime.new(year, month, day, hour, minute)
  end
end