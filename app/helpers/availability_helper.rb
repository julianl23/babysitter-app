module AvailabilityHelper
  def parse_availability_date(date_string)
    time = Time.at(date_string.to_i / 1000)
    time.to_datetime
  end

  def format_available_block_string(availability)
    from_string = availability.from.strftime('%B %-d %l:%M %p')
    to_string = availability.to.strftime('%B %-d %l:%M %p')
    "Availability for #{availability.user.full_name} from #{from_string} to #{to_string}"
  end
end
