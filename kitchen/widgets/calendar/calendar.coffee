class Dashing.Calendar extends Dashing.Widget

  onData: (data) =>
    event = rest = null
    getEvents = (first, others...) ->
      event = first
      rest = others

    getEvents data.events...

    start = moment(event.start)
    end = moment(event.end)
    timezone = 'America/New_York'

    @set('event',event)
    @set('event_date', start.tz(timezone).format('dddd'))

    if event.is_all_day
      @set("event_times", "All day")
    else 
      @set('event_times', start.tz(timezone).format('h:mm a') + " - " + end.tz(timezone).format('h:mma'))

    next_events = []
    for next_event in rest
      start = moment(next_event.start).tz(timezone)
      start_date = start.format('ddd')
      if next_event.is_all_day
        start_time = "ALL DAY"
      else 
        start_time = start.format('h:mma')

      next_events.push { summary: next_event.summary, start_date: start_date, start_time: start_time }
    @set('next_events', next_events)
