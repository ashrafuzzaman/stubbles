require 'charter/chart_base'
require 'gruff'

module Charter
  class LineChart < ChartBase
    def to_blob
      g = Gruff::Line.new
      g.title = self.title

      columns.each do |column|
        if column.kind_of?(Array)
          key, text = column[0], column[1]
        else
          key, text = column, column.to_s.humanize
        end

        g.data(text, data_for_column(key))
      end

      labels = {}
      data_for_column(label_column).each_with_index do |label, index|
        labels[index] = label.to_s
      end

      g.labels = labels
      g.to_blob
    end

    def render_chart(html_dom_id)
      api_name = Charter.config.web_api.to_s
      load "charter/#{api_name}_line_chart.rb"
      js_type = api_name.camelize
      chart = "Charter::#{js_type}LineChart".constantize.new()
      chart.data, chart.columns, chart.label_column = self.data, self.columns, self.label_column
      chart.render_chart(html_dom_id)
    end
  end
end