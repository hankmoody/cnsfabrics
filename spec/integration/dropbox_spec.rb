require 'rails_helper'
require 'dropbox_sdk'

describe 'Dropbox API' do

  before(:all) do
    @client = DropboxClient.new(DROPBOX_CFG["access_token"])
    @test_root = '/Cnsfabrics/test_folder/'
    @file_path = Rails.root.join('spec/support/images/small_image.png')
    @file = File.open(@file_path, 'r')

    response = @client.search('/Cnsfabrics', 'test_folder')
    if response.empty? || response.nil?
      @client.file_create_folder(@test_root)
    end
  end

  after(:all) do
    @file.close
  end

  it 'uploads multiple files to dropbox and reads them out' do
    print "Writing files..."
    test_file_path = @test_root + '/testfile.jpg'
    response = @client.put_file(test_file_path, @file)
    expect(response["bytes"]).to eq(@file.size)
    print "done\n"

    print "Download files..."
    contents = @client.get_file(test_file_path)
    print "done\n"

    print "Deleting files..."
    response = @client.file_delete(test_file_path)
    expect(response["bytes"]).to eq(0)
    print "done\n"
  end
end
