class Dashing.Solaredge extends Dashing.Widget

  data = {}

  ready: ->
    @display()
    setInterval(@display, 5000)

  display: =>
    if @data

      power = Math.round(@data['currentPower'])

      if power < 1000
        unit = 'W'
      else
        power = power / 1000
        unit = 'kW'
      @set('current-power', "#{power} #{unit}")

      energy = Math.round(@data['todayEnergy']) / 1000
      @set('today-energy', "#{energy} kWh")

  onData: (data) ->
    @data = data
