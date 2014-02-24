class Backend::BaseController < ApplicationController
  protect_from_forgery
  layout "dashboard"
end
