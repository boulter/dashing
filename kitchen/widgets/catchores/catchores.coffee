class Dashing.Catchores extends Dashing.Widget

  ready: ->
    setInterval(@display, 1000)

  display: =>
    weekOfYear = moment(new Date()).format('w ww')
    
    audrey = "water"
    elliott = "food"
    
    if weekOfYear % 2 == 1
      audrey = "food"
      elliott = "\uD83D\uDCA7"
    
    @set('title', "\uD83D\uDC31")
    @set('audrey', "Audrey: #{ audrey }")
    @set('elliott', "Elliott: #{ elliott }")
