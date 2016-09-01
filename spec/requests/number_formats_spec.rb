require 'rails_helper'

RSpec.describe "NumberFormats", type: :request do
  describe "GET /number_formats" do
    it "works! (now write some real specs)" do
      get number_formats_path
      expect(response).to have_http_status(200)
    end
  end
end
