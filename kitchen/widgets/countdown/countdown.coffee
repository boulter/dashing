class Dashing.Countdown extends Dashing.Widget

  ready: ->
    setInterval(@startCountdown, 500)

  startCountdown: =>
    current_timestamp = Math.round(new Date().getTime()/1000)
    end_timestamp = Math.round( Date.parse($(@node).find(".more-info").html())/1000 )
    seconds_until_end = end_timestamp - current_timestamp
    if seconds_until_end < 0
      @set('timeleft', "It's here!")
      for i in [0..100] by 1
        $(@node).fadeTo('fast', 0).fadeTo('fast', 1.0)
    else
      d = Math.floor(seconds_until_end/86400)
      @set('timeleft', d)