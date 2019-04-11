require 'json'
require 'line_notify'

@line_notify = LineNotify.new(get_token)
options = {
  message: "#{action_to_string} - #{event_name}: #{@event['check']['notification']}",
}
@line_notify.send(options)