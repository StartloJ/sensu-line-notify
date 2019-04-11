# sensu-line-notify
This repo is create for plugins compatibility on sensu-core version\
[![Gem Version](https://badge.fury.io/rb/sensu-plugins-gelf.svg)](http://badge.fury.io/rb/sensu-plugins-gelf)
[![Dependency Status](https://gemnasium.com/sensu-plugins/sensu-plugins-gelf.svg)](https://gemnasium.com/sensu-plugins/sensu-plugins-gelf)

## Functionality
Handler
- **handler-linenoti.rb**

## Configuration
- `line_token` <*string*>\
This config to get line-notify API token in string format

## Files
 * bin/handler-linenoti.rb

## Usage
### Example with use optional [json_config]
sensu/conf.d/line-notify.json
```json
{
  "line": {
    "line_token": "<TOKEN>"
  }
}
```
\
sensu/conf.d/handler/handlers-line.json
```json
{
  "handlers": {
    "line": {
      "type": "pipe",
      "command": "handler-gelf.rb --json 'gelf'",
    }
  }
}
```

## Installation
This not official plugin you must use `./gem` in path [ `/opt/sensu/embedded/bin/` ]
* install [specific_install](https://github.com/rdp/specific_install) in gem lib.
```
sudo ./gem install specific_install
```
* install sensu-linenotify plugins with specific_install
```
sudo ./gem specific_install https://github.com/StartloJ/sensu-line-notify.git
```

## Notes