class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = {
      pending: current_user.pending_bookings,
      booked: current_user.accepted_bookings
    }

    if current_user.babysitter?
      # TODO: .all is bad and doesn't scale well
      @availabilities = current_user.availabilities.all
    end
  end
end
