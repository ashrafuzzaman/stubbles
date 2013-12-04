require 'charter/chart_base'
require 'gruff'

module Charter
  class ChartJsLineChart < ChartBase
    def render(html_dom_id)
      datasets = []
      colors = Charter.config.chart[:chart_js][:colors]

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

      html = <<-HTML
        <script src="//cdnjs.cloudflare.com/ajax/libs/Chart.js/0.2.0/Chart.min.js" type="text/javascript"></script>
        <script type="application/javascript" class="chart_script">
          var lineChartData = {
              labels: #{data_for_column(label_column).to_json},
              datasets: #{datasets.to_json}
          }
          var myLine = new Chart(document.getElementById("#{html_dom_id}").getContext("2d")).Line(lineChartData, {bezierCurve: false});
        </script>
      HTML
      html.html_safe
    end
  end
end