'use strict'

angular.module('terribleMusicApp')
  .controller 'MainCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]

    window.AudioContext = window.AudioContext||window.webkitAudioContext
    window.context = new AudioContext()

    window.soundBuffer = null

    setSoundBuffer = (buffer) ->
      window.soundBuffer = buffer

    window.loadSound = (url) ->
      request = new XMLHttpRequest()
      request.open('GET', url, true)
      request.responseType = 'arraybuffer'

      # Decode asynchronously
      request.onload = ->
        context.decodeAudioData request.response, setSoundBuffer#, onError

      request.send()

    window.playSound = (buffer, bend) ->
      bend = 0 unless bend?
      source = context.createBufferSource() # creates a sound source
      semitoneRatio = Math.pow(2, 1/12)
      source.playbackRate.value = Math.pow(semitoneRatio, bend * 12)
      source.buffer = buffer                # tell the source which sound to play
      source.connect(context.destination)   # connect the source to the context's destination (the speakers)
      source.start(0)                       # play the source now

    loadSound("/audio/Glass.m4a")

    # now run `playSound(soundBuffer, numOctavesToBend)` in your console!
    # playSound(soundBuffer, -1); playSound(soundBuffer, -2); playSound(soundBuffer, -3);
