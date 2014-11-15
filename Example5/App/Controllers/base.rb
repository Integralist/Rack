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

