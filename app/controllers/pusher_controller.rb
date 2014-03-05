class PusherController < ActionController::Base

  def pusher
    webhook = Pusher.webhook(request)
    if webhook.valid?
      webhook.events.each do |event|
        case event["name"]
        when 'channel_occupied'
          device = Device.find_or_create_by_channel_name event["channel"]
          unless device.unassigned?
            device.active!
            Pusher.trigger(event["channel"], 'close_registration', {})
          else
            Pusher.trigger(event["channel"], 'unregistered', {:code => device.access_token})
          end
        when 'channel_vacated'
          device = Device.find_by_channel_name event["channel"]
          device.inactive! if device.active?
        end
      end
      render text: 'ok'
    else
      render text: 'invalid', status: 401
    end
  end
end
