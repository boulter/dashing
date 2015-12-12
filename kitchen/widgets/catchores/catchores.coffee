class Dashing.Catchores extends Dashing.Widget

  ready: ->
    setInterval(@display, 1000)

  display: =>
    weekOfYear = moment().format('W')

    audrey = "water"
    elliott = "food"

    if weekOfYear % 2 == 1
      audrey = "food"
      elliott = "water"

    @set('title', "Cat chores")
    @set('audrey', "Audrey: #{ audrey }")
    @set('elliott', "Elliott: #{ elliott }")
