require "erb"
require "tilt"

class App
  def self.call(env)
    Rack::Response.new(render "test")
  end

  def self.render(view)
    # Functional style FTW...
    render_template("Layouts/base") do
      render_template(view)
    end
  end

  def self.render_template(path, &block)
    # `render` takes a block which allows the template to yield to
    # If no block provided then `render` works as normal
    Tilt.new("App/Views/#{path}.html.erb").render(&block)
  end
end

use Rack::Static, :urls => ["/Assets"]

run App
