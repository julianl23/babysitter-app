class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    unless @user
      redirect_to dashboard_path
    end

    # https://stackoverflow.com/questions/18199705/ruby-on-rails-how-to-get-the-current-week-and-loop-through-it-to-display-its-da
    today = Date.today # Today's date
    @days_from_this_week = (today.at_beginning_of_week(:sunday)..today.at_end_of_week(:sunday))
  end
end