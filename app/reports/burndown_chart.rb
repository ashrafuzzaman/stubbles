class BurndownChart
  attr_accessor :milestone

  def initialize(milestone)
    @milestone = milestone
  end

  def to_google_chart
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Date')
    data_table.new_column('number', 'Hours remain')
    data_table.new_column('number', 'Estimated hours remain')

    milestone.burn_down_chart_data.each do |data|
      data_table.add_row [data[:date], data[:hours_remain], data[:estimated_hours_remain]]
    end

    opts   = { :width => 400, :height => 240, :title => 'Burndown chart', :legend => 'bottom' }
    @chart = GoogleVisualr::Interactive::LineChart.new(data_table, opts)
  end
end