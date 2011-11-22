Given /^I have created a client application$/ do
  visit '/client_applications/new'

  fill_in 'Name', :with => 'My Client Application'
  fill_in 'Description', 
      :with => 'Description of my client application'

  click_button 'Create'

  page.should have_content 'My Client Application'
  @application_key = ClientApplication.last.key
  @application_secret = ClientApplication.last.secret
end

When /^I create a client application$/ do
  visit '/client_applications/new'

  fill_in 'Name', :with => 'My Client Application'
  fill_in 'Description', 
      :with => 'Description of my client application'

  click_button 'Create'
end
def client
  Capybara.current_session.driver
end

When /^My client application authenticates$/ do
  #get user authorization and temp code
  client.browser.process(:get, "/oauth/authorize?response_type=code&client_id=#{@application_key}&state=test")
  client.response.should be_redirect
  @grant_code = Rack::Utils.parse_nested_query(client.response["Location"])["code"]
  @grant_code.should_not == ""
end

Then /^My client has an access token$/ do
  client.browser.process(:get, "/oauth/access_token?client_id=#{@application_key}&client_secret=#{@application_secret}&code=#{@grant_code}")
  client.response.should be_ok
  client.response.body["access_token"].should_not be_nil
end

Then /^I have a key and secret for the application$/ do
  find('li#application_key').should_not == ""
  find('li#application_secret').should_not == ""
end
