require 'rails_helper'

RSpec.describe "Tops", type: :request do
  describe "GET /tops" do
    it "works! (now write some real specs)" do
      get tops_path
      expect(response).to have_http_status(200)
    end
  end
end
