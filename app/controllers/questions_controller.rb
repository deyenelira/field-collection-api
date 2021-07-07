class QuestionsController < ApplicationController
  
  before_action :set_question, only: [:show, :update, :destroy]

  def index
    @questions = Question.all

    render json: @questions
  end

  def show
    render json: @question
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      render json: @question, status: :created, location: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_params
      params.permit(:name, :formulary_id, :question_type, :image)
    end
end
