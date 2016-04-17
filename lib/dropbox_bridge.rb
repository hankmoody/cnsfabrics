class DropboxBridge

  def initialize
    @client = DropboxClient.new(DROPBOX_CFG["access_token"])
    @root_path = '/Cnsfabrics/images/'
  end

  def get_file (file)
    path = find_file file
    contents = @client.get_file(path)
    file = Tempfile.new([file, File.extname(path)], :encoding => 'BINARY')
    file.write(contents)
    file
  end

  def find_file (file)
    path = nil
    file = add_extension_delimiter(file)
    results = @client.search(@root_path, file)
    if results.empty? || results.nil? || results.count > 1
      raise "#{file} not found in the images folder"
    else
      path = results.first["path"]
    end
    path
  end

  private

  def add_extension_delimiter (file)
    file + '.' if file.count('.') == 0
  end
end
