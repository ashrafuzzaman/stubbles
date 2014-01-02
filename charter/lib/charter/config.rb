module Charter
  class Configuration
    include ActiveSupport::Configurable
    config_accessor :web_api_name
    config_accessor :chart
    config_accessor :web_background_color
    config_accessor :web_colors
  end
end