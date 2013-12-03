require 'charter/chart_base'
require 'gruff'

module Charter
  class ChartJsLineChart < ChartBase
    COLORS = [
        {
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
        }
    ]


    def render(html_dom_id)
      datasets = []

      columns.each_with_index do |column, i|
        if column.kind_of?(Array)
          key, text = column[0], column[1]
        else
          key, text = column, column.to_s.humanize
        end
        color = COLORS[i%2]
        datasets << {
            fillColor: color[:fill_color],
            strokeColor: color[:stroke_color],
            pointColor: color[:point_color],
            pointStrokeColor: color[:point_stroke_color],
            data: data_for_column(key)}
      end

      <<-HTML
        <script type="application/javascript">
          var lineChartData = {
              labels: #{data_for_column(label_column).to_json},
              datasets: #{datasets.to_json}
          }
          var myLine = new Chart(document.getElementById("#{html_dom_id}").getContext("2d")).Line(lineChartData, {bezierCurve: false});
        </script>
      HTML
    end
  end
end