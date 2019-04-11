#!/usr/bin/env ruby
#
# Sensu Line notify Handler


require 'json'
require 'line_notify'
require 'sensu-handler'

class LinenotiHandler < Sensu::Handler

	option :json_config,
        description: 'Configuration label name',
        short: '-j JSONCONFIG',
        long: '--json JSONCONFIG',
        default: 'line'
	
	def action_to_string
		@event['action'].eql?('resolve') ? 'RESOLVE' : 'ALERT'
	end
	
	def event_name
    @event['client']['name'] + '/' + @event['check']['name']
	end

	def get_token
		get_setting(line_token)

	def get_setting(name)
		setting[config[:json_config]][name]
	rescue TypeError, NoMethodError => e
    puts "settings: #{settings}"
    puts "error: #{e.message}"
    exit 3 # unknown
	end

	def handle
		puts "something"
		line_notify = LineNotify.new(line_token)
		options = {
				message: "#{action_to_string} - #{event_name}: #{@event['check']['notification']}",
		}
		line_notify.send(options)
	end
end