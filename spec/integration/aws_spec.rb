require 'rails_helper'

describe 'Uploading files to S3' do
  let(:s3) { AWS::S3.new }
  let(:bucket) { s3.buckets['cnsbucket'] }

  it 'uploads multiple files to S3 and reads them out' do
    print "Writing files..."
    5.times do |i|
      bucket.objects["file#{i}.txt"].write("DATA")
    end
    print "done\n"

    print "Reading files..."
    5.times do |i|
      expect(bucket.objects["file#{i}.txt"].read).to eq("DATA")
    end
    print "done\n"

    print "Deleting files..."
    5.times do |i|
      bucket.objects["file#{i}.txt"].delete
      expect(bucket.objects["file#{i}.txt"].exists?).to be false
    end
    print "done\n"
  end
end
