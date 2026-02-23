require 'rails_helper'

RSpec.describe "Constructions", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/constructions/index"
      expect(response).to have_http_status(:success)
    end
  end

end
