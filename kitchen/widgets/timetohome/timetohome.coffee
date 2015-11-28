class Dashing.Timetohome extends Dashing.Widget

  onData: (data) ->
    @data = data
    text = ""
    for label,loc of @data.locations
      @set(label, "#{ loc.minutesToHome } mins / #{ Math.round(loc.distanceToHome) } mi") 
    @set('title', "Time to Home")
