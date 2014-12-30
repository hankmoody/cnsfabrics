class AddFabricWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options :retry => false

  def perform(record)
    image = add_image_path_to record
    unless image.nil?
      add record
      image.unlink
    end
  end

  private

  def add (record)
    log_status 'info', 'Adding design to database'
    fabric = Fabric.new record
    if fabric.save
      log_status 'success', 'Design added successfully!'
    else
      log_status 'danger', 'Failed with error ' + fabric.errors.messages.inspect
    end
  end

  def add_image_path_to (record)
    image = get_image_from_dropbox record
    unless image.nil?
      image.open()
      record["image"] = image
    end
    image
  end

  def get_image_from_dropbox (record)
    log_status 'info', 'Getting image from dropbox'
    begin
      dbox = DropboxBridge.new
      image = dbox.get_file record["code"]
    rescue Exception => e
      log_status 'danger', e.to_s
      return nil
    end
    image
  end

  def log_status(status, message)
    store status_code: status
    store status_message: message
  end
end
