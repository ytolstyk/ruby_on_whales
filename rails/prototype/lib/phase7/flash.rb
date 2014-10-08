require "json"

class Flash
  # find the cookie for this app
  # deserialize the cookie into a hash

  def initialize(req)
    @cookie_hash = {}
    @req = req

    cookie = req.cookies.find do |i|
      i.name == "_rails_lite_app_flash"
    end

    if cookie
      @cookie_hash = JSON.parse(cookie.value) 
      if @cookie_hash["flashed"].nil?
        @cookie_hash["flashed"] = true
      end
    end
  end

  def [](key)
    key = key.to_s
    @cookie_hash[key]
  end

  def []=(key, val)
    key = key.to_s
    @cookie_hash["flashed"] = nil
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
