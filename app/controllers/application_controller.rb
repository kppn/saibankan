class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :logined_user, :project_name_tilte

  rescue_from 'Exception' do |e|
    render json: { message: e.message }.to_json, status: :internal_server_error
  end


  private
    def logined_user
      @user = current_user
    end

    # relate has_many association
    #   ex) relate_has_many(number, Mark, mark_ids)
    def relate_has_many(relatee, relation_model, ids)
      ids.each do |id|
        relatee.send(relation_model.table_name) << relation_model.find(id)
      end
    end

    # unrelate has_many association
    def unrelate_has_many(relatee, relation_model, ids)
      ids.each do |id|
        relatee.send(relation_model.table_name).delete relation_model.find(id)
      end
    end

    # viewのヘッダーに表示する用のプロジェクト名を作成
    # ProjectのRESTルーティングのidの形式差は吸収する
    #   ProjectリソースへのRESTではid, その配下ではproject_id
    #   e.g.)          project GET    /projects/:id(.:format)
    #          project_numbers GET    /projects/:project_id/numbers(.:format)
    def project_name_tilte
      id = if self.kind_of? ProjectsController
             params[:id]
           else
             params[:project_id]
           end

      @project_name_tilte = id ? Project.find(id).name : ''
    end
end

