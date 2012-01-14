def a_get(path, params = nil)
  url = Dwolla.endpoint + path
  url += "?#{params}" if params
  a_request(:get, url)
end

def a_post(path)
  url = Dwolla.endpoint + path
  a_request(:post, url)
end

def stub_get(path, params = nil)
  url = Dwolla.endpoint + path
  url += "?#{params}" if params
  stub_request(:get, url)
end

def stub_post(path)
  url = Dwolla.endpoint + path
  stub_request(:post, url)
end

def fixture_path
  File.expand_path("../../fixtures", __FILE__)
end

def fixture(file)
  IO.read(fixture_path + '/' + file)
end
