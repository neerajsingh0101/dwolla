def a_get(path, params, endpoint = Dwolla.endpoint)
  a_request(:get, endpoint + path + '?' + params)
end

def stub_get(path, params, endpoint = Dwolla.endpoint)
  stub_request(:get, endpoint + path + '?' + params)
end

def fixture_path
  File.expand_path("../../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
