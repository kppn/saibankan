class NumbersController < ApplicationController
  before_action :set_number, only: []
  before_action :set_project, only: [:index, :create]

  # GET /numbers
  # GET /numbers.json
  def index
    @numbers = @project.numbers
  end

  # POST /numbers
  # POST /numbers.json
  def create
    @number = @project.numbers.build

    @number.val = allocate_number @project
    @number.users << @user

    mark_ids = params[:number] && params[:number][:mark_ids] || []
    relate_has_many @number, Mark, mark_ids


    respond_to do |format|
      if @number.save
        format.html { redirect_to project_path(@project) }
        format.json { render :show, status: :created, location: @number }
      else
        format.html { render :new }
        format.json { render json: @number.errors, status: :bad_request }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_number
    #   @number = Number.find(params[:id])
    # end

    def set_project
      @project = Project.find params[:project_id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def number_params
      params.require(:number).permit(:allocated, :project_id, :mark_ids)
    end

    def allocate_number(project)
      number_format = project.number_formats.first
      number_format.build binding
    end
end
