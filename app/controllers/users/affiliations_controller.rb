class Users::AffiliationsController < ApplicationController
  before_action :set_affiliation, only: [:destroy]

  # POST /affiliations
  # POST /affiliations.json
  def create
    @affiliation = Affiliation.new(affiliation_params)

    respond_to do |format|
      if @affiliation.save
        format.html { redirect_to :back }
        #format.json { render :show, status: :created, location: @affiliation }
      else
        format.html { redirect_to :back }
        #format.json { render json: @affiliation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /affiliations/1
  # DELETE /affiliations/1.json
  def destroy
    @affiliation.destroy
    respond_to do |format|
      format.html { redirect_to users_home_path, notice: 'Affiliation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_affiliation
      @affiliation = Affiliation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def affiliation_params
      params.require(:affiliation).permit(:project_id, :user_id, :administrator)
    end
end
