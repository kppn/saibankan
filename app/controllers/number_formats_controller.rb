class NumberFormatsController < ApplicationController
  before_action :set_number_format, only: [:show, :edit, :update, :destroy]

  # GET /number_formats
  # GET /number_formats.json
  def index
    @number_formats = NumberFormat.all
  end

  # GET /number_formats/1
  # GET /number_formats/1.json
  def show
  end

  # GET /number_formats/new
  def new
    @number_format = NumberFormat.new
  end

  # GET /number_formats/1/edit
  def edit
    (10-@number_format.number_parts.count).times do
      @number_format.number_parts.build
    end
  end

  # POST /number_formats
  # POST /number_formats.json
  def create
    @number_format = NumberFormat.new(number_format_params)

    respond_to do |format|
      if @number_format.save
        format.html { redirect_to @number_format, notice: 'Number format was successfully created.' }
        format.json { render :show, status: :created, location: @number_format }
      else
        format.html { render :new }
        format.json { render json: @number_format.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /number_formats/1
  # PATCH/PUT /number_formats/1.json
  def update
    params = number_format_params
    Rails.logger.debug params
    
    #return redirect_to :back
    drop_empty_parts_params params

    Rails.logger.debug params

    respond_to do |format|
      if @number_format.update(params)
        format.html { redirect_to :action => 'edit' }
        format.json { render :show, status: :ok, location: @number_format }
      else
        format.html { render :edit }
        format.json { render json: @number_format.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /number_formats/1
  # DELETE /number_formats/1.json
  def destroy
    @number_format.destroy
    respond_to do |format|
      format.html { redirect_to number_formats_url, notice: 'Number format was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_number_format
      @number_format = NumberFormat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def number_format_params
      params.require(:number_format).permit(:project_id, number_parts_attributes: [:format, :type, :id])
    end

    def drop_empty_parts_params params
      params[:number_parts_attributes].delete_if do |key, val|
        val[:format].empty? || val[:type].nil? || val[:type].empty?
      end
    end
end
