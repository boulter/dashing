class Dashing.School extends Dashing.Widget

  ready: ->
    setInterval(@display, 1000)

  getAudrey: (today) ->

    if (today.getHours() == 19 && today.getMinutes() >= 30) || today.getHours() > 19
      return "Go to bed"

    day = today.getDay()

    switch day
      when 1 then "Art"
      when 2 then "Music, PE, Cello"
      when 3 then "PE"
      when 4
        if moment().format('W') % 2 == 0
          "All-school meeting"
        else
          "Book Buddies"
      when 5 then "Music, Library"
      else "Stay at home"

  getElliott: (today) ->

    if (today.getHours() == 19 && today.getMinutes() >= 30) || today.getHours() > 19
      return "Go to bed"

    day = today.getDay()

    switch day
      when 1 then "PE"
      when 2 then "Library"
      when 3 then "Music"
      when 4
        if moment().format('W') % 2 == 0
          "All-school meeting"
        else
          "Music"
      when 5 then "PE"
      else "Stay at home"

  display: =>

    today = new Date()
    @set('audrey', "#{ @getAudrey(today) }")
    @set('elliott', "#{ @getElliott(today) }")
