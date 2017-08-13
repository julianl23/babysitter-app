class BookingsController < ApplicationController
  def create
    booking_properties = booking_params
    booking_properties['from'] = helpers.parse_datetime_date('from', booking_properties)
    booking_properties['to'] = helpers.parse_datetime_date('to', booking_properties)

    booking = Booking.new(booking_properties)
    booking.save!
    flash[:notice] = "Booking request sent! #{booking.babysitter.full_name} will contact you soon."
    redirect_to dashboard_path
  end

  def accept
    booking = Booking.find(params[:id])
    booking.accept

    flash[:notice] = "You have accepted the booking with #{booking.family.full_name}."
    redirect_to dashboard_path
  end

  def decline
    booking = Booking.find(params[:id])
    booking.decline
    flash[:notice] = "You have declined the booking with #{booking.family.full_name}."
    redirect_to dashboard_path
  end

  private

  def booking_params
    params.require(:booking).permit(:babysitter_id, :family_id, :availability_id, :from, :to)
  end
end
