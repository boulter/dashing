class Dashing.Timetohome extends Dashing.Widget

  onData: (data) ->
    @data = data
    text = ""
    for label,loc of @data.locations
      if loc.minutesToHome == 0
        @set(label, "at home") 
      else
        @set(label, "#{ loc.minutesToHome } mins / #{ Math.round(loc.distanceToHome) } mi") 
    @set('title', "Time to Home")
