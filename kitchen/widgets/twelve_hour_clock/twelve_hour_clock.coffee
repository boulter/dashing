class Dashing.TwelveHourClock extends Dashing.Widget

  ready: ->
    setInterval(@startTime, 1000)

  startTime: =>
    now    = moment()
    @set('time', now.format('h:mm'))
    @set('dayOfWeek',  now.format('dddd'))
    @set('dayOfMonth',  now.format('D'))
    @set('month', now.format('MMMM'))
