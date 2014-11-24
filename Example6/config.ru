$: << "."

require "pry"
require "erb"
require "tilt"

require "Middleware/cache"

require "App/Controllers/base"
require "App/Controllers/list"
require "App/Models/item"

class App
  def self.call(env)
    if env["PATH_INFO"] == "/"
      Rack::Response.new(List.new.create)
    else
      Rack::Response.new("Not found?", 404)
    end
  rescue Exception => e
    Rack::Response.new("Server Error? #{e.backtrace.join('\n')}", 500)
  end
end

cache_headers = {
  :cache_control => "max-age=2678400, public", # 86400 seconds == 1 day * 31
  :expires => 2678400
}
use Cache, { :assets => cache_headers }
use Rack::Static, :urls => ["/Assets"]

run App
