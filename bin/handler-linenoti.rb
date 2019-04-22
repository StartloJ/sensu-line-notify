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
  
  option :enable_stk,
        description: 'This option is define to enable feature send sticker to line_notify',
        short: '-s',
        long: '--enable_stk',
        default: false,
        boolean: true

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
      message: "#{action_to_string}!\s#{@event['check']['notification']}\nLevel: #{translate_status}\n #{event_name} \n#{@event['check']['output']}",
      stickerPackageId: sticker_pkg_id[0]
      stickerId: sticker_pkg_id[1]
    }
    @line_notify.send(options)
  end

  def check_status
    @event['check']['status']
  end

  def sticker_pkg_id
    if enable_stk
      case check_status
      when 0
        return 2,175
      when 1
        return 2,152
      when 2
        return 2,19
      when 3
        return 2,45
      end
    else
      return nil,nil
    end
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
