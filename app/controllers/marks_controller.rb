class MarksController < ApplicationController
  before_action :set_mark, only: [:edit, :update, :destroy]

  # GET /marks
  # GET /marks.json
  def index
    @user_marks    = @user.marks
    @project_marks = @user.projects.map{|p| p.marks}.inject{|s, marks| s + marks}
  end

  # GET /marks/new
  def new
    @mark = Mark.new
  end

  # GET /marks/1/edit
  def edit
  end

  # POST /marks
  # POST /marks.json
  def create
    @mark = Mark.new
    if mark_params[:owner] == 'User'
      @mark.owner = @user
    else
      @mark.owner = Project.find mark_params[:owner]
    end
    @mark.label = mark_params[:label]
    @mark.description = mark_params[:description]

    respond_to do |format|
      if @mark.save
        format.html { redirect_to :action => 'index' }
        format.json { render :show, status: :created, location: @mark }
      else
        format.html { render :new }
        format.json { render json: @mark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /marks/1
  # PATCH/PUT /marks/1.json
  def update
    respond_to do |format|
      if @mark.update(mark_params)
        format.html { redirect_to :action => "index" }
        format.json { render :show, status: :ok, location: @mark }
      else
        format.html { render :edit }
        format.json { render json: @mark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /marks/1
  # DELETE /marks/1.json
  def destroy
    @mark.destroy
    respond_to do |format|
      format.html { redirect_to marks_url, notice: 'Mark was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mark
      @mark = Mark.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mark_params
      params.require(:mark).permit(:owner, :label, :description)
    end
end
