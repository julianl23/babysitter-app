class AvailabilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_role, except: :show

  def new
    @availability = Availability.new
  end

  def create
    user_id = params[:user_id]

    if !user_id.present? || !user_id == current_user.id
      respond_to do |format|
        format.html
        format.json do
          render json: { error: 'Not authorized' }, status: 403
        end
      end
    else
      @availability = Availability.new
      posted_availability = params[:availability]

      @availability.from = helpers.parse_availability_date(posted_availability[:from])
      @availability.to = helpers.parse_availability_date(posted_availability[:to])
      @availability.note = posted_availability[:note]
      @availability.user_id = params[:user_id]

      @availability.save!

      respond_to do |format|
        format.html do
          flash[:notice] = 'Availability created'
          redirect_to new_user_availability_path
        end

        format.json do
          flash[:notice] = 'Availability created'
          render json: {
            entities: {
              availability: @availability
            }
          }, status: 201
        end
      end
    end
  end

  def destroy
    availability_id = params[:id]

    current_user.availabilities.find(availability_id).destroy

    respond_to do |format|
      flash[:notice] = 'Availability removed'
      format.html do
        redirect_to user_path current_user
      end

      format.json do
        render json: {
          success: true,
          message: 'Availability removed'
        }, status: 202
      end
    end
  end

  def show
    @availability = Availability.find params[:id]
    @booking = Booking.new
  end

  private
  def check_role
    unless current_user.role.name == 'babysitter'
      flash[:alert] = 'You are not authorized to perform this action.'
      respond_to do |format|
        format.html do
          redirect_to dashboard_path
        end

        format.json do
          render json: {
            error: 'unauthorized'
          }, status: 403
        end
      end
    end
  end
end
