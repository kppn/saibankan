require 'rails_helper'

RSpec.describe "NumberParts", type: :request do
  describe "GET /number_parts" do
    it "works! (now write some real specs)" do
      get number_parts_path
      expect(response).to have_http_status(200)
    end
  end
end
