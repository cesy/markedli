Given /^I have created a client application$/ do
  visit '/client_applications/new'

  fill_in 'Name', :with => 'My Client Application'
  fill_in 'Description', 
      :with => 'Description of my client application'

  click_button 'Create'

  page.should have_content 'My Client Application'
  @application_key = find('#application_key').text
  @application_secret = find('#application_secret').text
end

When /^I create a client application$/ do
  visit '/client_applications/new'

  fill_in 'Name', :with => 'My Client Application'
  fill_in 'Description', 
      :with => 'Description of my client application'

  click_button 'Create'
end

When /^My client application authenticates$/ do
  #get user authorization and temp code
  get "/oauth/authorize?response_type=code&client_id=#{@application_key}&state=test"
  last_response.should be_redirect
  @grant_code = get_param_from_response last_response, "code"
  @grant_code.should_not be_nil
  @grant_code.should_not be_empty
end

Then /^My client has an access token$/ do
  get "/oauth/access_token?client_id=#{@application_key}&client_secret=#{@application_secret}&code=#{@grant_code}"
  last_response.should be_ok
  last_response.body["access_token"].should_not be_nil
  last_response.body["access_token"].should_not be_empty
end

Then /^I have a key and secret for the application$/ do
  find('li#application_key').text.should_not be_empty
  find('li#application_secret').text.should_not be_empty
end
