module Charter
  class Configuration
    include ActiveSupport::Configurable
    config_accessor :web_api
  end
end