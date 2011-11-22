class OauthController < ApplicationController
  def authorize
    client_application = ClientApplication.with_id(params[:client_id])
    @access_grant = AccessGrant.create(:client_application => client_application)
    redirect_to "#{params[:redirect_uri]}&code=somecode&response_type=code"
  end
  def access_token
    client_application = ClientApplication.authorize(params[:client_id], params[:client_secret])
    if client_application.nil?
      render :json => {:error => "No client application found"}.to_json
      return
    end

    access_grant = AccessGrant.authorize(client_application, params[:code])
    if access_grant.nil?
      render :json => {:error => "No grant found"}.to_json
      return
    end

    render :json => {:access_token => access_grant.access_token}.to_json
  end
end
