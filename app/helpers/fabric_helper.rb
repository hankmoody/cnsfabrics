module FabricHelper

  def process_record (record)
    fabric = Fabric.find_by code: record[:code]
    if fabric.nil?
      add_record record
    else
      update_record record
    end
  end

  def add_record (record)
    fabric = Fabric.new record
    if fabric.save
      @status << { :success => "#{record[:code]} added successfully." }
    else
      @status << { :danger => "#{record[:code]} failed with error " + fabric.errors.messages.inspect }
    end
  end

  def update_record (record)
    if fabric.update_attributes record
      @status << { :success => "#{record[:code]} was updated successfully." }
    else
      @status << { :danger => "#{record[:code]} failed with error " + fabric.errors.messages.inspect }
    end
  end

end
