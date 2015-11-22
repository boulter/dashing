class Dashing.Catchores extends Dashing.Widget

  ready: ->
    setInterval(@display, 1000)

  display: =>
    weekOfYear = moment(new Date()).format('w ww')
    
    audrey = "water"
    elliott = "food"
    
    if weekOfYear % 2 == 1
      audrey = "food"
      elliott = "water"
    
    @set('title', "Cat chores")
    @set('audrey', "Audrey: #{ audrey }")
    @set('elliott', "Elliott: #{ elliott }")
