module CapybaraApp
  def app
    Capybara.app
  end
end
module ApiHelpers
  def get_param_from_response response, param
    Rack::Utils.parse_nested_query(response["Location"])[param]
  end
end
World(ApiHelpers)
World(CapybaraApp)
World(Rack::Test::Methods)
