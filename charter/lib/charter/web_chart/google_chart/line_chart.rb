require 'charter/line_chart'

module Charter
  module WebChart
    module GoogleChart
      class LineChart < Charter::LineChart
        def render(html_dom_id)
          js = <<-JS
            google.load("visualization", "1", {packages:["corechart"]});
            google.setOnLoadCallback(drawChart);
            function drawChart() {
              var data = google.visualization.arrayToDataTable(#{array_data_table.to_json});

              var options = {
                title: '#{title}',
                backgroundColor: '#{Charter.config.web_background_color}',
                colors: #{Charter.config.web_colors.to_json}
              };

              var chart = new google.visualization.LineChart(document.getElementById('#{html_dom_id}'));
              chart.draw(data, options);
            }
          JS
          js.html_safe
        end

        protected
        def array_data_table
          array_data = [[label_column] + column_names]
          array_data + data.collect do |row|
            [row[label_column]] + column_keys.collect { |col| row[col] }
          end
        end
      end
    end
  end
end