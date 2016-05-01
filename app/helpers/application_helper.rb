module ApplicationHelper

  def bootstrap_class_for flash_type
    case flash_type
      when :success
        "alert-success"
      when :error
        "alert-danger"
      when :alert
        "alert-warning"
      when :notice
        "alert-info"
      else
        flash_type.to_s
    end
  end

  def rename_file (old_file, new_file)
    File.rename(old_file, new_file)
    new_file
  end

  def admin?
    current_user && current_user.admin?
  end

  def site_title
    return 'Cnsfabrics' if @site_title.nil?
    return @site_title
  end
end
