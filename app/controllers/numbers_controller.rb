class NumbersController < ApplicationController
  before_action :set_number, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:index]

  # GET /numbers
  # GET /numbers.json
  def index
    @numbers = @project.numbers
  end

  # GET /numbers/1
  # GET /numbers/1.json
  def show
  end

  # GET /numbers/new
  def new
    @number = Number.new
  end

  # GET /numbers/1/edit
  def edit
  end

  # POST /numbers
  # POST /numbers.json
  def create
    @project = Project.find(params[:project_id])
    @number = @project.numbers.build

    @number.val = allocate_number(@project, @user)
    @number.users << @user

    mark_ids = params[:number] && params[:number][:mark_ids] || []
    relate_marks @number, mark_ids

    respond_to do |format|
      if @number.save
        format.html { redirect_to project_path(@project) }
        format.json { render :show, status: :created, location: @number }
      else
        format.html { render :new }
        format.json { render json: @number.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /numbers/1
  # PATCH/PUT /numbers/1.json
  def update
    respond_to do |format|
      if @number.update(number_params)
        format.html { redirect_to @number, notice: 'Number was successfully updated.' }
        format.json { render :show, status: :ok, location: @number }
      else
        format.html { render :edit }
        format.json { render json: @number.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /numbers/1
  # DELETE /numbers/1.json
  def destroy
    @number.destroy
    respond_to do |format|
      format.html { redirect_to numbers_url, notice: 'Number was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_number
      @number = Number.find(params[:id])
    end

    def set_project
      @project = Project.find params[:project_id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def number_params
      params.require(:number).permit(:allocated, :project_id, :mark_ids)
    end

    def allocate_number project, user
      number_format = project.number_formats.first
      number_format.build binding
    end

    def relate_marks number, mark_ids
      mark_ids.each do |mark_id|
        number.marks << Mark.find(mark_id)
      end
    end
end
