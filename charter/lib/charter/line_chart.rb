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

    end
  end
end