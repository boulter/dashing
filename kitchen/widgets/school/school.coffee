class Dashing.School extends Dashing.Widget

  ready: ->
    setInterval(@display, 1000)

  getAudrey: (day) ->
    switch day
      when 1 then "Art"
      when 2 then "Music"
      when 3 then "PE, Music"
      when 4
        if moment().format('W') % 2 == 1
          "All-school meeting, PE"
        else
          "Buddies, PE"
      when 5 then "Library"
      else "Stay at home"

  getElliott: (day) ->
    switch day
      when 1 then "Library"
      when 2 then "PE"
      when 3 then "Music"
      when 4
        if moment().format('W') % 2 == 1
          "All-school meeting, Music, PE"
        else
          "Buddies, Music, PE"
      when 5 then "Art"
      else "Stay at home"

  display: =>
    today    = new Date()
    dayOfWeek = today.getDay()

    @set('dayOfWeek', moment(today).format('dddd'))

    @set('audrey', "Audrey: #{ @getAudrey(dayOfWeek) }")
    @set('elliott', "Elliott: #{ @getElliott(dayOfWeek) }")
