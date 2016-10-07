class Api::V1::NumbersController < Api::V1Controller
  before_action :set_project, only: [:create]
  before_action :set_user, only: [:create]
  before_action :check_request, only: [:create]

  # 注意：後優先
  rescue_from StandardError, with: :rescue_standard_error
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_bad_request
  rescue_from ActionController::UnpermittedParameters, with: :rescue_bad_request
  rescue_from ActionController::BadRequest, with: :rescue_bad_request


  # POST /numbers
  # POST /numbers.json
  def create
    Rails.logger.info ['API: number assignment requested', {request: request_loginfo}]

    affiliate_user_to_project_if_yet

    @number = build_new_number
    if @number.save
      marking_if_mark_requested number_params[:mark]
      render json: @number
    else
      render json: { message: @number.errors.values.join(' ') }.to_json, status: :bad_request
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    
    def number_params
      params.permit(:format, :project_name, :user, :number => {}, :mark => [:label, :description])
    end
    

    def set_project
      @project = Project.find_by!(name: params[:project_name])
    end

    def set_user
      @user = User.find_by!(email: number_params[:user])
    end

    def check_request
      ActionController::Parameters.action_on_unpermitted_parameters = :raise
      
      raise ActionController::BadRequest.new unless request.media_type == 'application/json'
      raise ActionController::BadRequest.new unless params[:user]
    end


    # マークを付与する(登録されてなければ新しく作る)
    def marking_if_mark_requested(mark_params)
      return unless mark_params
      return unless mark_params[:label]

      mark = Mark.find_or_create_by(label: mark_params[:label], owner_id: @user.id, owner_type: 'User') do |mark|
               mark.description = mark_params[:description]
             end
      @number.marks << mark
    end

    # 新しい番号を作成し関連付けする
    def build_new_number
      @project.numbers.build do |number|
        number.val = allocate_number @project
        number.users << @user
      end
    end

    # 採番する
    def allocate_number(project)
      number_format = project.number_formats.first
      number_format.build binding
    end

    # ユーザをプロジェクトに所属させる(まだ所属していなければ)
    def affiliate_user_to_project_if_yet
      unless @user.projects.include? @project
        @user.projects << @project
      end
    end

    # ログ用のリクエスト情報抜粋
    def request_loginfo
      {
        method:          request.method,
        fullpath:        request.fullpath,
        original_url:    request.original_url,
        media_type:      request.media_type,
        content_length:  request.content_length,
        ip:              request.ip,
        remote_ip:       request.remote_ip,
        uuid:            request.uuid,
        body:            request.body.read,
      }
    end

    def rescue_bad_request
      Rails.logger.warn $!
      Rails.logger.warn ['parameter error', params]
      render(json: {message: $!.message}, status: 400) and return
    end

    def rescue_standard_error
      Rails.logger.warn $!
      Rails.logger.warn ['any error', params]
      render(json: {message: $!.message}, status: 500) and return
    end

end
