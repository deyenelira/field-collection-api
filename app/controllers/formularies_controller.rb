class FormulariesController < ApplicationController
  
  before_action :set_formulary, only: [:show, :update, :destroy]

  def index
    @formularies = Formulary.all

    render json: @formularies
  end

  def show
    render json: @formulary
  end

  def create
    @formulary = Formulary.new(formulary_params)

    if @formulary.save
      render json: @formulary, status: :created, location: @formulary
    else
      render json: @formulary.errors, status: :unprocessable_entity
    end
  end

  def update
    if @formulary.update(formulary_params)
      render json: @formulary
    else
      render json: @formulary.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @formulary.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_formulary
      @formulary = Formulary.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def formulary_params
      params.permit(:name)
    end
end
