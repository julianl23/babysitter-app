module UserHelper
  def format_week_of_string(days_of_week)
    first_day = days_of_week.first
    last_day = days_of_week.last
    "Week of #{first_day.strftime '%B %-d, %Y'} to #{last_day.strftime '%B %-d, %Y'}"
  end

  def timestamp_for_cell(date, hour)
    timestamp_date = Time.new(date.year, date.month, date.mday, hour, 0).in_time_zone
    timestamp_date.to_i * 1000
  end

  def available_from_string(from_date, to_date)
    from_string = from_date.strftime('%B %-d %l:%M %p')
    to_string = to_date.strftime('%l:%M %p')
    "Available #{from_string} to #{to_string}"
  end

  def availability_for_hour(user, availabilities, day, hour)
    day_at_hour = day.change({ hour: hour })
    current_availabilities = availabilities.select { |availability| day_at_hour >= availability.from && day_at_hour <= availability.to }
    tag_content = ''
    tag_classes = ['calendar-hour']
    user_is_babysitter = user_signed_in? && current_user.babysitter?
    user_is_family = user_signed_in? && current_user.family?

    if current_availabilities.empty? && user_is_babysitter && user.id == current_user.id
      tag_content = button_tag(fa_icon('plus'), class: 'booking-btn', data: { time: timestamp_for_cell(day, hour)})
    elsif !current_availabilities.empty?
      availability = current_availabilities[0]
      from_date = availability.from
      to_date = availability.to
      day_at_hour_i = day_at_hour.to_i
      from_date_i = from_date.to_i
      to_date_i = to_date.to_i

      if day_at_hour_i == from_date_i
        if current_user == availability.user
          tag_content = available_from_string(from_date, to_date).html_safe
          tag_content << link_to(fa_icon('times'), user_availability_path(current_user, availability.id), class: 'btn', method: 'delete')
        elsif user_is_family
          tag_content = link_to(available_from_string(from_date, to_date), user_availability_path(availability.user, availability))
        end
        tag_classes << 'available start'
      elsif day_at_hour_i > from_date_i && day_at_hour_i < to_date_i
        if user_is_family
          tag_content = link_to('', '', class: 'block-calendar-link')
        end
        tag_classes << 'available middle'
      elsif day_at_hour_i == to_date_i
        if user_is_family
          tag_content = link_to('', '', class: 'block-calendar-link')
        end
        tag_classes << 'available end'
      end
    end

    content_tag(:div, tag_content, class: tag_classes.join(' '))
  end
end