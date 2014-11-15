$: << "."

require "erb"
require "tilt"

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
  end
end

use Rack::Static, :urls => ["/Assets"]

run App
