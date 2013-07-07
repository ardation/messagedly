class Backend::BaseController < ActionController::Base
  protect_from_forgery
  layout "application"
end
