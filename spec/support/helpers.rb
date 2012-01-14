def a_get(path, params = nil)
  url = Dwolla.endpoint + path
  url += "?#{params}" if params
  a_request(:get, url)
end

def stub_get(path, params = nil)
  url = Dwolla.endpoint + path
  url += "?#{params}" if params
  stub_request(:get, url)
end

def fixture_path
  File.expand_path("../../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
