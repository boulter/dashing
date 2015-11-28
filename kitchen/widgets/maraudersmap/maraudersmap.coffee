class Dashing.Maraudersmap extends Dashing.Widget

  setMarkers: ->
    if !@markers
      @markers = {}

    if @data
      bounds = new google.maps.LatLngBounds()
      latSum = 0
      longSum = 0
      locationCount = 0
      for label,loc of @data.locations
        latSum += loc.latitude
        longSum += loc.longitude
        locationCount += 1
        pos = new google.maps.LatLng(loc.latitude, loc.longitude)
        bounds.extend pos

        icon =
          url: loc.icon
          scaledSize: new google.maps.Size(50, 50)

        markerOpts = 
          position: pos
          icon: icon
          map: @map
          clickable: false
        marker = new google.maps.Marker markerOpts

        if @markers[label]
          @markers[label].setMap(null)

        @markers[label] = marker
      if @map
        @centroid = new google.maps.LatLng(latSum/locationCount, longSum/locationCount)
        @map.panTo @centroid 
        @map.panToBounds bounds 
        @traffic.setMap(null)
        @traffic = new google.maps.TrafficLayer()
        @traffic.setMap(@map)
    
  ready: ->
    $(@node).removeClass('widget')
    zoom =  $(@node).data('zoom')
    lat  = 42.4305897
    long = -71.1340644
    zoom = 13
    options =
      zoom: zoom
      center: new google.maps.LatLng(lat,long)
      disableDefaultUI: true
      draggable: false
      scrollwheel: false
      disableDoubleClickZoom: true

    @map = new google.maps.Map $(@node)[0], options
    @traffic = new google.maps.TrafficLayer
    @traffic.setMap(@map)
    @markers = {}
    @setMarkers()

  onData: (data) ->
    @data = data
    @setMarkers()
      