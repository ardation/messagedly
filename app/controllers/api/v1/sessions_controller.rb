class Api::V1::SessionsController < Devise::SessionsController
  respond_to :html, :json
  def create
    respond_to do |format|
      format.html { super }
      format.json {
        warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
        return sign_in_and_redirect(resource_name, resource)
      }
    end
  end

  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(resource, warden.user(scope))
    return render :json => {:success => true, :redirect => stored_location_for(scope) || after_sign_in_path_for(resource), :access_token => warden.user(scope).devices.where(channel_name: params[:device][:uuid]).first_or_create.access_token}
  end

  def failure
    return render:json => {:success => false}
  end
end
