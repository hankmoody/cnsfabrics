require 'rails_helper'
require_relative '../../lib/fabric_sheet_reader.rb'

describe 'Fabric Sheet Reader' do
  let(:excel_repo) { 'spec/support/files/' }

  it 'successfully parses records from a valid excel file' do
    sheet_reader = FabricSheetReader.new(excel_repo + 'sheet_basic_valid.xlsx')
    records = sheet_reader.read_fabric_data
    result = [
      {
        :code => "test 123",
        :width => 44,
        :quantity => 2000,
        :tag_list => "checks, stripes"
      },
      {
        :code => "test 245",
        :width => 55,
        :quantity => 3500,
        :tag_list => "stripes, voile"
      }
    ]
    expect(records).to eq(result)

    record = records.first
    fabric = Fabric.new record
    expect(fabric.code).to eq(record[:code])
    expect(fabric.width).to eq(record[:width])
    expect(fabric.quantity).to eq(record[:quantity])
    expect(fabric.tag_list).to eq(record[:tag_list])
  end

  it 'fails if number of records are out of bounds' do
    expect{FabricSheetReader.new(excel_repo + 'sheet_row_out_of_bounds.xlsx')}.to raise_error
  end

  it 'fails if number of columns are out of bounds' do
    expect{FabricSheetReader.new(excel_repo + 'sheet_column_out_of_bounds.xlsx')}.to raise_error
  end

  it 'fails if any of the column title is incorrect' do
    expect{FabricSheetReader.new(excel_repo + 'sheet_wrong_column_title.xlsx')}.to raise_error
  end

  it 'fails if any of the rows have an empty code' do
    sheet_reader = FabricSheetReader.new(excel_repo + 'sheet_empty_code.xlsx')
    expect{sheet_reader.read_fabric_data}.to raise_error
  end

  it 'fails if any of the rows have a duplicate code' do
    sheet_reader = FabricSheetReader.new(excel_repo + 'sheet_duplicate_code.xlsx')
    expect{sheet_reader.read_fabric_data}.to raise_error
  end
end
