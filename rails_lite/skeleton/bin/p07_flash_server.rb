require 'webrick'
require_relative '../lib/phase6/controller_base'
require_relative '../lib/phase6/router'
require_relative '../lib/phase4/controller_base'
require_relative '../lib/phase7/flash.rb'

# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html

# class MyController < Phase4::ControllerBase
#   def go
#     session["count"] ||= 0
#     session["count"] += 1
#     render :counting_show
#   end
# end

# server = WEBrick::HTTPServer.new(Port: 8001)
# server.mount_proc('/') do |req, res|
#   flash = Flash.new(req)
#   flash["error"] = "Something"
#   res.body = flash["error"]
# end

server = WEBrick::HTTPServer.new(Port: 8001)
server.mount_proc('/') do |req, res|
  res.body = Phase6::ControllerBase.new(req, res).button_to("Name", "http://www.google.com")
end

trap('INT') { server.shutdown }
server.start