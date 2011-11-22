require 'spec_helper'

describe OauthController do
  describe '#authorize' do
    let(:client_application) { ClientApplication.create! Factory.attributes_for(:client_application) }
    let(:client_key) { client_application.key }
    it "creates an AccessGrant for the application" do
      expect {
        get :authorize, :client_id => client_key
      }.to change(AccessGrant, :count).by(1)
      assigns(:access_grant).client_application.should == client_application
    end
    it "redirects the user back to the client" do
      redirect_uri = "http://client.com"
      get :authorize, :client_id => client_key, :redirect_uri => redirect_uri
      response.should be_redirect
      #response.should redirect_to
    end
  end
  describe "#access_token" do
    it "verifies the client application"
    it "authorizes the access grant with the temporary code"
    it "responds with an access token"
  end
end
