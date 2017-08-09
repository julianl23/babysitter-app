class AvailabilitiesController < ApplicationController
  before_action :authenticate_user!, only: :availability_test

  def new
    return unless current_user.role.name == 'babysitter'

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
      # @availability.from = helpers.parse_availability_date('from', posted_availability)
      # @availability.to = helpers.parse_availability_date('to', posted_availability)

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
          render json: {
            entities: {
              availability: @availability
            }
          }, status: 201
        end
      end
    end
  end
end
