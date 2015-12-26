require "rails_helper"

RSpec.describe RecordsController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the records into @records" do
      record1 = Record.create title: 'Record 1', date: Date.today, amount: 500
      record2 = Record.create title: 'Record 2', date: Date.today, amount: -100
      get :index

      expect(assigns(:records)).to match_array([record1, record2])
    end
  end
end