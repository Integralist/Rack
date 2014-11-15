require "erb"
require "tilt"

class App
  def self.call(env)
    if env["PATH_INFO"] == "/"
      @items = ["Foo", "Bar", "Baz"]
      Rack::Response.new(render "test")
    else
      Rack::Response.new("Not found?", 404)
    end
  end

  def self.render(view)
    # Functional style FTW...
    render_template("Layouts/base") do
      render_template(view)
    end
  end

  def self.render_template(path, &block)
    # `render` takes a block which allows the template to yield to
    # It can also (optionally) take a "context" (in this case `self`)
    # If no block provided then `render` works as normal
    #
    # `base` is rendered and it yields to a block
    # that itself renders the partial template `test`
    # the `test` template is given the `App` class as its context
    # so it can access the `@items` Array
    Tilt.new("App/Views/#{path}.html.erb").render(self, &block)
  end
end

use Rack::Static, :urls => ["/Assets"]

run App
