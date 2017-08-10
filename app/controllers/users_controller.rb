class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    unless @user
      redirect_to dashboard_path
    end

    # https://stackoverflow.com/questions/18199705/ruby-on-rails-how-to-get-the-current-week-and-loop-through-it-to-display-its-da
    today = Date.current.in_time_zone # TODO: Make this timezone match the user's timezone through geolocation
    beginning_of_week = today.beginning_of_week(:sunday).to_datetime
    end_of_week = today.end_of_week(:sunday).to_datetime
    @days_from_this_week = (beginning_of_week..end_of_week).to_a

    @availabilities = Availability.where user_id: @user.id
  end
end