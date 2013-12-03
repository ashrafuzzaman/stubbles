module Charter
  autoload :Configuration, "charter/config"

  def self.configure(&block)
    yield @config ||= Charter::Configuration.new
  end

  def self.config
    @config
  end

  configure do |config|
    config.web_api_name = 'chart_js'
    config.chart = {chart_js: {colors: [{
                                            fill_color: "rgba(220,220,220,0.5)",
                                            stroke_color: "rgba(220,220,220,1)",
                                            point_color: "rgba(220,220,220,1)",
                                            point_stroke_color: "#fff"
                                        },
                                        {
                                            fill_color: "rgba(151,187,205,0.5)",
                                            stroke_color: "rgba(151,187,205,1)",
                                            point_color: "rgba(151,187,205,1)",
                                            point_stroke_color: "#fff"
                                        }]}
    }
  end
end
