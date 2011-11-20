When /^I create a client application$/ do
  visit '/client_applications/new'

  fill_in 'Name', :with => 'My Client Application'
  fill_in 'Description', 
      :with => 'Description of my client application'

  click_button 'Create'
end

Then /^I have a key and secret for the application$/ do
  find('li#application_key').should_not == ""
  find('li#application_secret').should_not == ""
end
