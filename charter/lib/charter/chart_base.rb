require 'charter/gruff_themes'

module Charter
  class ChartBase
    attr_accessor :title, :data, :columns, :label_column

    # data: array of hash
    # [{date: 2013-1-2, hours_remain: 2, estimated_hours_remain: 10},
    # {date: 2013-1-3, hours_remain: 4, estimated_hours_remain: 10},
    # {date: 2013-1-4, hours_remain: 10, estimated_hours_remain: 10}]

    def initialize
      columns, data = [], []
    end

    def add_row(row)
      data << row
    end

    def render_chart(html_dom_id, options = {})
      api_name = options[:web_api_name] || Charter.config.web_api_name.to_s
      class_name = self.class.name.split("::")[1]
      load "charter/#{api_name}_#{class_name.underscore}.rb"
      js_type = api_name.camelize
      chart = "Charter::#{js_type}#{class_name}".constantize.new
      chart.data, chart.columns, chart.label_column = self.data, self.columns, self.label_column
      chart.render(html_dom_id)
    end

    def self.evaluate_js
      "eval($('script.chart_script').text());"
    end

    protected
    def prepare_gruff
      g = Gruff::Line.new
      g.theme = Charter::Themes::GOOGLE_CHART
      g.title = self.title
      g
    end

    def data_for_column(column_name)
      data.map { |row| row[column_name] }
    end
  end
end