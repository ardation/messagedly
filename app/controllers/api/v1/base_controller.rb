class Api::V1::BaseController < InheritedResources::Base
  before_filter :ensure_login
  respond_to :json

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  protected

    def ensure_login
      unless oauth_access_token
        render json: {errors: ['Missing access token']}, status: :unauthorized, callback: params[:callback]
        return false
      end
      unless current_device
        render json: {errors: ['Invalid access token']}, status: :unauthorized, callback: params[:callback]
        return false
      end
    end

    def current_device
      @current_device ||= Device.from_access_token(oauth_access_token)
    end

    def oauth_access_token
      oauth_access_token ||= (params[:access_token] || oauth_access_token_from_header)
    end


    # grabs access_token from header if one is present
    def oauth_access_token_from_header
      auth_header = request.env["HTTP_AUTHORIZATION"]||""
      match       = auth_header.match(/^token\s(.*)/) || auth_header.match(/^Bearer\s(.*)/)
      return match[1] if match.present?
      false
    end

    def render_404
      render nothing: true, status: 404
    end

    def begin_of_association_chain
      @current_device
    end

end
