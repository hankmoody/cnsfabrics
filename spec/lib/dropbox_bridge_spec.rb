require 'rails_helper'
require 'dropbox_sdk'
require 'dropbox_bridge'

describe 'Dropbox Bridge' do

  before(:all) do
    @client = DropboxClient.new(DROPBOX_CFG["access_token"])
    @test_root = '/Cnsfabrics/images/'
    @file_path = Rails.root.join('spec/support/images/small_image.png')
    @file = File.open(@file_path, 'r')

    response = @client.search('/Cnsfabrics', 'images')
    if response.empty? || response.nil?
      @client.file_create_folder(@test_root)
    end

    @test_file_path = @test_root + 'cnstest 123.png'
    @client.put_file(@test_file_path, @file)

    @db = DropboxBridge.new
  end

  after(:all) do
    @file.close
    @client.file_delete(@test_file_path)
  end

  it "successfully finds the file if it exists" do
    path = @db.find_file 'cNStest 123'
    expect(path).to eq(@test_file_path)
    temp_file = @db.get_file 'cnstest 123'
    expect(@file_path.size).to eq(temp_file.size)
    temp_file.unlink
  end

  it "raises an error if file is not found" do
    @db = DropboxBridge.new
    expect{@db.find_file 'Cnstest 345'}.to raise_error
  end
end
