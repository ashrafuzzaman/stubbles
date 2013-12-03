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

    protected
    def data_for_column(column_name)
      data.map{ |row| row[column_name] }
    end
  end
end