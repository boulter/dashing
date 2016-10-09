class Dashing.School extends Dashing.Widget

  ready: ->
    setInterval(@display, 1000)

  getAudrey: (today) ->

    if (today.getHours() == 19 && today.getMinutes() >= 15) || today.getHours() > 19
      return "Go to bed"

    day = today.getDay()

    switch day
      when 1 then "Music"
      when 2 then "Art"
      when 3 then "PE, Music"
      when 4
        if moment().format('W') % 2 == 0
          "All-school meeting, Library"
        else
          "Library"
      when 5 then "PE"
      else "Stay at home"

  getElliott: (today) ->

    if (today.getHours() == 19 && today.getMinutes() >= 15) || today.getHours() > 19
      return "Go to bed"

    day = today.getDay()

    switch day
      when 1 then "Art"
      when 2 then "Music, PE"
      when 3 then "Music"
      when 4
        if moment().format('W') % 2 == 0
          "All-school meeting, Book Buddies"
        else
          ""
      when 5 then "Library, PE"
      else "Stay at home"

  display: =>

    today = new Date()
    @set('audrey', "#{ @getAudrey(today) }")
    @set('elliott', "#{ @getElliott(today) }")
