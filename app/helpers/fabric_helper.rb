module FabricHelper

  def process_record (record)
    fabric = Fabric.find_by code: record[:code]
    if fabric.nil?
      add_record record
    else
      update_record fabric, record
    end
  end

  def add_record (record)
    image_file = add_image_path_to record
    fabric = Fabric.new record
    if fabric.save
      @status << { :success => "#{record[:code]} added successfully." }
    else
      @status << { :danger => "#{record[:code]} failed with error " + fabric.errors.messages.inspect }
    end
    image_file.unlink
  end

  def update_record (fabric, record)
    if fabric.update_attributes record
      @status << { :success => "#{record[:code]} was updated successfully." }
    else
      @status << { :danger => "#{record[:code]} failed with error " + fabric.errors.messages.inspect }
    end
  end

  def add_image_path_to (record)
    image_file = @dbox.get_file record[:code]
    image_file.open()
    record[:image] = image_file
    image_file
  end
end
