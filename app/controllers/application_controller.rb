class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :logined_user, :project_name_tilte



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

    def unrelate_has_many(relatee, relation_model, ids)
      ids.each do |id|
        relatee.send(relation_model.table_name).delete relation_model.find(id)
      end
    end

    def project_name_tilte
      id = if self.kind_of? ProjectsController
             params[:id]
           else
             params[:project_id]
           end

      @project_name_tilte = id ? Project.find(id).name : ''
    end
end

