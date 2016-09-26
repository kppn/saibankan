class MarkingsController < ApplicationController
  before_action :set_marking, only: [:index, :create]

  # GET /projects/1/markings
  def index
    @markings = @number.markings
    @all_marks = @project.marks + @user.marks
  end


  # POST /markings
  # POST /markings.json
  def create
    add_mark_ids = marking_params['add_mark_ids']&.map(&:to_i) || []
    sub_mark_ids = marking_params['sub_mark_ids']&.map(&:to_i) || []

    relate_has_many(@number, Mark, add_mark_ids)
    unrelate_has_many(@number, Mark, sub_mark_ids)

    redirect_to action: 'index'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marking
      @number = Number.find(params[:number_id])
      @project = @number.project
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marking_params
      params.require(:markings).permit(:mark_ids => [], :add_mark_ids => [], :sub_mark_ids => [])
    end
end
