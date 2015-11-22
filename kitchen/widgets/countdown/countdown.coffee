class Dashing.Countdown extends Dashing.Widget

  ready: ->
    @startCountdown()
    setInterval(@startCountdown, 60000)

  startCountdown: =>
    daysLeft = Math.max(0, Math.ceil((moment($(@node).find(".more-info").html()) - moment())/86400000))
    @set('timeleft', daysLeft)