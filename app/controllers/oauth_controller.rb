class OauthController < ApplicationController
  def authorize
    client_application = ClientApplication.where(key: params[:client_id]).last
    @access_grant = AccessGrant.create(:client_application => client_application)
    redirect_to "#{params[:redirect_uri]}&code=somecode&response_type=code"
  end
end
