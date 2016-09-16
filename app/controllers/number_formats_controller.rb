class NumberFormatsController < ApplicationController
  before_action :set_number_format, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:new, :create]

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
    @number_format = @project.number_formats.build
    10.times do
      part = @number_format.number_parts.build 
      part.format = ''
    end
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
    @number_format.project = @project

    respond_to do |format|
      if @number_format.save
        Rails.logger.debug 'number_format create success'
        format.html { redirect_to project_path(@project) }
        format.json { render :show, status: :created, location: @number_format }
      else
        Rails.logger.debug 'number_format create fails'
        Rails.logger.debug @number_format.errors.messages
        format.html { render :new }
        format.json { render json: @number_format.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /number_formats/1
  # PATCH/PUT /number_formats/1.json
  def update
    params = number_format_params
    regulate_empty_parts_params params[:number_parts_attributes]

    respond_to do |format|
      if @number_format.update(params)
        Rails.logger.debug 'update validation success'

        # paramsのtypeを元に単にupdateでは, STIのクラスが変更されない(typeカラムも変わらない)
        transform_parts_type @number_format.number_parts, params[:number_parts_attributes]
        initialize_empty_parts @number_format.number_parts

        format.html { redirect_to :action => 'edit' }
        format.json { render :show, status: :ok, location: @number_format }
      else
        Rails.logger.debug 'update validation fails'

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
      @project = @number_format.project
    end

    def set_project
      @project = Project.find params[:project_id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def number_format_params
      params.require(:number_format).permit(:project_id, number_parts_attributes: [:format, :type, :id])
    end

    def regulate_empty_parts_params number_parts_params
      number_parts_params.each do |key, val|
        if val[:format].empty? || val[:type].nil? || val[:type].empty?
          val[:format] = ''
          val[:type] = nil
        end
      end
    end

    def transform_parts_type number_parts, number_parts_params
      id_based_hash = to_id_based_hash number_parts_params
      number_parts.each do |number_part|
        if type = id_based_hash[number_part.id][:type]
          number_part.update_column(:type, type)
          type_updated_number_part = number_part.becomes!(type.constantize)
          # モデルのsaveコールバックを発生させる
          type_updated_number_part.save
        end
      end
    end

    # "0"=>{"format"=>"aaa", "type"=>"FixedPart", "id"=>"94"}, ...
    #=> 94 => {"format"=>"aaa", "type"=>"FixedPart", "id"=>"94"}, ...
    def to_id_based_hash number_parts_params
      id_based_hash = {}
      number_parts_params.each do |key, val|
        id_based_hash[val[:id].to_i] = val
      end
      id_based_hash
    end

    def initialize_empty_parts number_parts
      number_parts.each do |number_part|
        Rails.logger.debug 'initialize_empty_parts #{number_part.format}'
        if number_part.format.blank? && number_part.type.present?
          Rails.logger.debug 'initialize_empty_parts type deletion #{number_part.type}'
          number_part.update_column(:type, nil)
        end
      end
    end
end
