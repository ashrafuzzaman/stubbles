require 'charter/bar_chart'

module Charter
  module WebChart
    module GoogleChart
      class BarChart < Charter::BarChart
        def render(html_dom_id)
          datasets = []
          colors = Charter.config.chart[:google_chart][:colors]

          columns.each_with_index do |column, i|
            if column.kind_of?(Array)
              key, text = column[0], column[1]
            else
              key, text = column, column.to_s.humanize
            end
            color = colors[i%colors.size]
            datasets << {
                fillColor: color[:fill_color],
                strokeColor: color[:stroke_color],
                pointColor: color[:point_color],
                pointStrokeColor: color[:point_stroke_color],
                data: data_for_column(key)}
          end

          js = <<-JS
            var lineChartData = {
                labels: #{data_for_column(label_column).to_json},
                datasets: #{datasets.to_json}
            }
            var myLine = new Chart(document.getElementById("#{html_dom_id}").getContext("2d")).Bar(lineChartData, {bezierCurve: false});
          JS
          js.html_safe
        end
      end
    end
  end
end