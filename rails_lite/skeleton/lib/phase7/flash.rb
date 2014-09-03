require "json"

class Flash
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    @req = req
    cookie = req.cookies.find do |i|
      i.name == "_rails_lite_app_flash"
    end

    if cookie
      @cookie_hash = JSON.parse(cookie.value)
      store_hash(res)
    end
    
    @cookie_hash = {}
  end

  def [](key)
    @cookie_hash[key]
  end

  def []=(key, val)
    @cookie_hash[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_hash(res)
    cookie = WEBrick::Cookie.new("_rails_lite_app_flash", @cookie_hash.to_json)
    res.cookies << cookie
  end

  def now
    #put message on response and render
    #delete the cookie_hash
  end
end
