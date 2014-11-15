require "erb"
require "tilt"

class App
  def self.call(env)
    if env["PATH_INFO"] == "/"
      Rack::Response.new(List.new.create)
    else
      Rack::Response.new("Not found?", 404)
    end
  end
end

class Base
  def render(view)
    render_template("Layouts/base") do
      render_template(view)
    end
  end

  def render_template(path, &block)
    Tilt.new("App/Views/#{path}.html.erb").render(self, &block)
  end
end

class List < Base
  def create
    @items = ["Foo!", "Bar!", "Baz!"]
    render "test"
  end
end

use Rack::Static, :urls => ["/Assets"]

run App
