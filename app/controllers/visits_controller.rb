class VisitsController < ApplicationController
  before_action :set_visit, only: [:show, :update, :destroy]

  def index
    @visits = Visit.all
    render json: @visits
  end

  def show
    render json: @visit
  end

  def create
    @visit = Visit.new(visit_params)

    if @visit.save
      render json: @visit, status: :created, location: @visit
    else
      render json: @visit.errors, status: :unprocessable_entity
    end
  end

  def update
    if @visit.update(visit_params)
      render json: @visit
    else
      render json: @visit.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @visit.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visit
      @visit = Visit.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def visit_params
      params.permit(:date, :status, :checkin_at, :checkout_at, :user_id)
    end
end
