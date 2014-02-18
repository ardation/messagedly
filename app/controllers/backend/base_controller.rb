class Backend::BaseController < ActionController::Base
  protect_from_forgery
  layout "dashboard"
end
