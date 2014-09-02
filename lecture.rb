require "webrick"
require "json"

server = WEBrick::HTTPServer.new(Port: 8001)
trap("INT") { server.shutdown } #ctrl-C

server.mount_proc "/" do |req, res| #request and response
  MyController.new(req, res, params).index 
  #pass params with req. params from routes

  #discarding request
  res.body = "Hello, world"

  puts req.query_string
  res.body = req.query_string
  #using ?key=val, we get "key=val" on the page

  res.status = 302 #set HTTP status
  #redirection response, location to go to
  res["Location"] = "https://google.com"

  #cookies are always passed around
  #cookies from the browser (client side)
  puts req.cookies

  #name and value
  res.cookies << WEBrick::Cookie.new("class", "new test cookie")
  res.body = "yum"

  #can store hash
  res.cookies << WEBrick::Cookie.new("_rails_lite",
     { a: "1", b: "2", session_token: "something" }.to_json)
end

server.start