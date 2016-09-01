class NumberPartsController < ApplicationController
  before_action :set_number_part, only: [:show, :edit, :update, :destroy]

  # GET /number_parts
  # GET /number_parts.json
  def index
    @number_parts = NumberPart.all
  end

  # GET /number_parts/1
  # GET /number_parts/1.json
  def show
  end

  # GET /number_parts/new
  def new
    @number_part = NumberPart.new
  end

  # GET /number_parts/1/edit
  def edit
  end

  # POST /number_parts
  # POST /number_parts.json
  def create
    @number_part = NumberPart.new(number_part_params)

    respond_to do |format|
      if @number_part.save
        format.html { redirect_to @number_part, notice: 'Number part was successfully created.' }
        format.json { render :show, status: :created, location: @number_part }
      else
        format.html { render :new }
        format.json { render json: @number_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /number_parts/1
  # PATCH/PUT /number_parts/1.json
  def update
    respond_to do |format|
      if @number_part.update(number_part_params)
        format.html { redirect_to @number_part, notice: 'Number part was successfully updated.' }
        format.json { render :show, status: :ok, location: @number_part }
      else
        format.html { render :edit }
        format.json { render json: @number_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /number_parts/1
  # DELETE /number_parts/1.json
  def destroy
    @number_part.destroy
    respond_to do |format|
      format.html { redirect_to number_parts_url, notice: 'Number part was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_number_part
      @number_part = NumberPart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def number_part_params
      params.require(:number_part).permit(:type, :format, :number_part_id, :current)
    end
end
