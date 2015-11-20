class Dashing.Calendar extends Dashing.Widget

  onData: (data) =>
    event = rest = null
    getEvents = (first, others...) ->
      event = first
      rest = others

    getEvents data.events...

    start = moment(event.start)
    end = moment(event.end)
    timezone = 'UTC'

    console.log("event " + event)

    @set('event',event)
    @set('event_date', start.tz(timezone).format('dddd'))
    @set('event_times', start.tz(timezone).format('h:mm a') + " - " + end.tz(timezone).format('h:mm a'))

    next_events = []
    for next_event in rest
      start = moment(next_event.start).tz(timezone)
      start_date = start.format('ddd')
      start_time = start.format('h:mm a')

      next_events.push { summary: next_event.summary, start_date: start_date, start_time: start_time }
    @set('next_events', next_events)
