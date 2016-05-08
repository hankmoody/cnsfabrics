module FabricHelper

  def process_record (record)
    fabric = Fabric.find_by code: record[:code].downcase
    if fabric.nil?
      job_id = AddFabricWorker.perform_async(record)
      @jobs[job_id] = record[:code]
    else
      update_record fabric, record
    end
  end

  def update_record (fabric, record)
    code = record[:code]
    if fabric.update_attributes record
      @update_status[code] = log_status('success', 'Updated Successfully')
    else
      @update_status[code] = log_status('danger', 'Failed with ' + fabric.errors.messages.inspect)
    end
  end

  def log_status (status, message)
    {
      :status_code    => status,
      :status_message => message
    }
  end
end
