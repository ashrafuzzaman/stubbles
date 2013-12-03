module Charter
  autoload :Configuration, "charter/config"

  def self.configure(&block)
    yield @config ||= Charter::Configuration.new
  end

  def self.config
    @config
  end

  configure do |config|
    config.web_api = 'chart_js'
  end
end
