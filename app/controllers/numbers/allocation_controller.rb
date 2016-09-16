class Numbers::AllocationController < ApplicationController
  before_action :set_project, only: [:create]

  # POST /projects/1/numbers/allocate.json
  def create
    @project = Project.find(params[:project_id])
    @number = @project.numbers.build

    @number.val = allocate_number(@project)

    @user = User.find_by(email: params[:user])

    if @number.save
      render :json => { number: @number.val }, status: :ok
    else
      render :json => { error_cause: 'Number allocation saving error'}, status: :ok
    end

    @number.users << @user
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

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def number_params
      params.require(:number).permit(:allocated, :project_id, :mark_ids)
    end

    def allocate_number project
      number_format = project.number_formats.first
      number_format.build
    end

    def relate_marks number, mark_ids
      mark_ids.each do |mark_id|
        number.marks << Mark.find(mark_id)
      end
    end
end
