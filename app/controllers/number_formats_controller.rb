class NumberFormatsController < ApplicationController
  before_action :set_number_format, only: [:edit, :update]
  before_action :set_project, only: [:new, :create]


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

    params = number_format_params
    blankize_empty_parts_params params[:number_parts_attributes]
    render(:new) && return if many_sequential_parts?(params[:number_parts_attributes])

    respond_to do |format|
      if @number_format.save
        format.html { redirect_to project_path(@project) }
        format.json { render :show, status: :created, location: @number_format }
      else
        format.html { render :new }
        format.json { render json: @number_format.errors, status: :bad_request }
      end
    end
  end

  # PATCH/PUT /number_formats/1
  # PATCH/PUT /number_formats/1.json
  def update
    # params[:number_parts_attributes]
    # => {
    #      "0"=>{"format"=>"aaa", "type"=>"FixedPart", "id"=>"94"},
    #      "1"=>{"format"=>"%Y%m", "type"=>"DatePart", "id"->"102"}, 
    #      ...
    
    params = number_format_params
    blankize_empty_parts_params params[:number_parts_attributes]
    render(:edit) && return if many_sequential_parts?(params[:number_parts_attributes])

    respond_to do |format|
      inherit_continuance_attributes do
        if @number_format.update(params)
          # paramsのtypeを元に単にupdateでは, STIのクラスが変更されない(typeカラムも変わらない)
          transform_parts_type @number_format.number_parts, params[:number_parts_attributes]
          # 中途半端な状態になったNumberPartは初期化する
          blankize_insufficiently @number_format.number_parts

          format.html { redirect_to :action => 'edit' }
          format.json { render :show, status: :ok, location: @number_format }
        else
          format.html { render :edit }
          format.json { render json: @number_format.errors, status: :bad_request }
        end
      end
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

    # 中途半端なパラメータは全て空にする
    def blankize_empty_parts_params number_parts_params
      number_parts_params.each do |key, val|
        if val[:format].empty? || val[:type].nil? || val[:type].empty?
          val[:format] = ''
          val[:type] = nil
        end
      end
    end

    # パラメータでNumberPartのtypeが指定されていれば、そのNumberPartのtypeを変更
    def transform_parts_type number_parts, number_parts_params
      id_based_hash = to_id_based_hash number_parts_params
      number_parts.each do |number_part|
        type = id_based_hash[number_part.id][:type]
        if type
          transform number_part, type.constantize
        end
      end
    end

    # paramsハッシュの形式を変更
    # "0"=>{"format"=>"aaa", "type"=>"FixedPart", "id"=>"94"}, ...
    #=> 94 => {"format"=>"aaa", "type"=>"FixedPart", "id"=>"94"}, ...
    def to_id_based_hash number_parts_params
      id_based_hash = {}
      number_parts_params.each do |key, val|
        id_based_hash[val[:id].to_i] = val
      end
      id_based_hash
    end

    # STI:modelのtypeを変える(クラスも変更)
    #
    # #<Hoge: id: 2, type: "Hoge", ...
    #=> #<Fuga: id: 2, type: "Fuga", ..
    def transform model, type
      model.update_column(:type, type.to_s)
      type_updated = model.becomes!(type)
      # モデルのsaveコールバックを発生させる
      type_updated.save
    end

    # 中途半端な状態のNumberPart(formatが空だがtypeがある)を初期化(全て空)する
    def blankize_insufficiently number_parts
      number_parts.each do |number_part|
        if number_part.format.blank? && number_part.type.present?
          number_part.reset
        end
      end
    end

    # 永続的なアトリビュートをupdate(STIタイプ変更)前後で引き継ぐ
    def inherit_continuance_attributes
      current = @number_format.number_parts.find_by(type: 'SequentialPart')&.current

      yield if block_given?

      new_seq_part = @number_format.number_parts.find_by(type: 'SequentialPart')
      new_seq_part&.update_column(:current, current)
    end

    # paramsに複数のSequentialPartsを含むか
    def many_sequential_parts? params
      params.values.many? do |h|
        h[:type] == 'SequentialPart'
      end
    end
end
