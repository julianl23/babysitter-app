class AvailabilitiesController < ApplicationController
  before_action :authenticate_user!, only: :availability_test

  def new
    return unless current_user.role.name == 'babysitter'

    @availability = Availability.new
  end

  def create
    @availability = Availability.new
    posted_availability = params[:availability]
    @availability.from = helpers.parse_availability_date('from', posted_availability)
    @availability.to = helpers.parse_availability_date('to', posted_availability)
    @availability.note = posted_availability[:note]
    @availability.user_id = params[:user_id]

    @availability.save!

    flash[:notice] = 'Availability created'
    redirect_to new_user_availability_path
  end
end