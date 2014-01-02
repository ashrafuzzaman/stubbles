require 'charter/pie_chart'

module Charter
  module WebChart
    module GoogleChart
      class PieChart < Charter::PieChart
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
                color: color[:fill_color],
                value: data_for_column(key)}
          end

          js = <<-JS
            var lineChartData = {
                datasets: #{datasets.to_json}
            }
            var myLine = new Chart(document.getElementById("#{html_dom_id}").getContext("2d")).Pie(lineChartData, {bezierCurve: false});
          JS
          js.html_safe
        end
      end
    end
  end
end