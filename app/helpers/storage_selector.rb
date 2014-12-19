module StorageSelector
  def storage_selector
    if %w(development test cucumber performance local_test).include?(Rails.env)
      @storage_selector = {
        path: ":rails_root/public/system/:attachment/:id/:style/:basename.:extension",
        url:  "/system/:attachment/:id/:style/:basename.:extension"
      }
    else
      @storage_selector = {
        :storage        => :s3,
        :s3_credentials => "#{Rails.root}/config/aws.yml",
        :path           => ":class/:attachment/:id/:style.:extension",
        :s3_protocol    => 'https'
      }
    end
  end
end
