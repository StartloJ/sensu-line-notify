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
				message: "Test",
		}
		line_notify.send(options)
	end
end
b = LinenotiHandler.new
b.handle