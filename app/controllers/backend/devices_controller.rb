class Backend::DevicesController < InheritedResources::Base
  protect_from_forgery
  layout "dashboard"

  add_breadcrumb "Home", :root_path

  add_breadcrumb "Devices", :devices_path

  def create
    device = Device.find_by_access_token params[:device][:access_token]
    unless device.blank?
      device.user = current_user
      device.status = :active
      device.save!
      Pusher.trigger(device.channel_name, 'close_registration', {})
      redirect_to devices_path
    else
      redirect_to new_device_path
    end
  end

  protected

  def begin_of_association_chain
    current_user
  end
end
