class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.babysitter?
      # TODO: .all is bad and doesn't scale well
      @availabilities = current_user.availabilities.all
    elsif current_user.family?
      @bookings = ''
    end
  end
end
