class Api::V1::NumbersController < Api::V1Controller
  before_action :set_project, only: [:create]
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
    Rails.logger.debug number_params.class
    Rails.logger.debug number_params.permitted?

    @user = User.find_by!(email: number_params[:user])

    @number = @project.numbers.build
    @number.val = allocate_number(@project, @user)
    @number.users << @user

    if @number.save
      marking(@number, @user, number_params[:mark]) if number_params[:mark]
      render json: @number
    else
      render json: @number.errors, status: :unprocessable_entity
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

    def marking(number, user, mark_params)
      return unless (mark_params || mark_params[:label])

      mark = Mark.find_by(label: mark_params[:label], owner_id: user.id, owner_type: 'User')
      unless mark
        mark = Mark.new(mark_params)
        mark.owner = user
        mark.save
      end
      number.marks << mark
    end

    def create_mark
    end

    def allocate_number(project, user)
      number_format = project.number_formats.first
      number_format.build binding
    end

    def rescue_bad_request
      Rails.logger.warn ['parameter error', params]
      render(json: {message: $!.message}, status: 400) and return
    end

    def rescue_standard_error
      Rails.logger.warn ['any error', params]
      render(json: {message: $!.message}, status: 500) and return
    end

    def check_request
      ActionController::Parameters.action_on_unpermitted_parameters = :raise
      
      raise ActionController::BadRequest.new unless request.media_type == 'application/json'
      raise ActionController::BadRequest.new unless params[:user]
    end

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
end
