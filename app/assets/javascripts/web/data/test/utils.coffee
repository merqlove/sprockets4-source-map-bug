hoursOptions = [0..23].map (val) ->
  {id: String(val), name: val}

minutesOptions = [0..59].map (val) ->
  {id: String(val), name: val}

timezoneMapping = {m: 'Moscow'}

timezoneOptions = [{m: 'Moscow'}]
  
web.utils =
  isFallback: (str) ->
    str?.indexOf?('fallback') >= 0
  hoursOptions: ->
    hoursOptions
  minutesOptions: ->
    minutesOptions
  timezoneName: (tz) ->
    timezoneMapping[tz]
  timezoneOptions: ->
    timezoneOptions
