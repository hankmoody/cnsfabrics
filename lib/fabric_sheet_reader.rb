class FabricSheetReader
  def initialize(file)
    @file = Roo::Excelx.new(file)
    @file.default_sheet = @file.sheets.first
    validate_file
  end

  def read_fabric_data
    records = []
    for i in 2..@file.last_row
      record = {}
      for j in 1..@file.last_column
        record[columns[j].to_sym] = @file.cell(i,j)
      end
      validate_record record, i
      records << record
    end
    records
  end

  private

  def validate_file
    check_bounds
    check_column_titles
  end

  def validate_record (record, row)
    if record[:code].nil? || record[:code].empty?
      raise "Row #{row}: Code cannot be empty!"
    end
  end

  def check_bounds
    if @file.last_row > 100
      raise 'Maximum of 100 rows allowed'
    end

    if @file.last_column != 3
      raise "Invalid number of columns. Please make sure column titles are #{columns.values.join(', ')}"
    end
  end

  def check_column_titles
    columns.each do |key, value|
      col = @file.cell(1, key)
      if col.downcase != value
        raise "Invalid column '#{col}'. Please make sure column titles are #{columns.values.join(', ')}"
      end
    end
  end

  def columns
    {
      1 => 'code',
      2 => 'width',
      3 => 'quantity'
    }
  end

end
