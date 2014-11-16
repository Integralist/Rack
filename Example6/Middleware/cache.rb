class Cache
  attr_reader :app, :pattern

  def initialize(app, pattern)
    @app = app
    @pattern = pattern
  end

  def call(env)
    app.call(env).tap do |res|
      pattern.each do |p, config|
        if env["REQUEST_PATH"] =~ generated_pattern(p)
          res[1]["Cache-Control"] = config[:cache_control] if config.has_key? :cache_control
          res[1]["Expires"] = (Time.now + config[:expires]).utc.rfc2822 if config.has_key? :expires
        end
      end
    end
  end

  private

  def generated_pattern(pattern)
    Regexp.new pattern.to_s.capitalize
  end
end
