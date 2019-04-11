#!/usr/bin/env ruby
#
# Sensu Line notify Handler
# Test with unrelease
#
#



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
    get_setting('line_token')
  end

  def get_setting(name)
    settings[config[:json_config]][name]
  rescue TypeError, NoMethodError => e
    puts "settings: #{settings}"
    puts "error: #{e.message}"
    exit 3 # unknown
  end

  def handle
    @line_notify = LineNotify.new(get_token)
    options = {
        message: "#{action_to_string} \n#{event_name} \n#{translate_status}: #{@event['check']['notification']}\s#{@event['check']['output']}",
    }
    @line_notify.send(options)
  end

  def check_status
    @event['check']['status']
  end

  def translate_status
    status = {
      0 => :OK,
      1 => :WARNING,
      2 => :CRITICAL,
      3 => :UNKNOWN
    }
    begin
      status.fetch(check_status.to_i)
    rescue KeyError
      status.fetch(3)
    end
  end

end
