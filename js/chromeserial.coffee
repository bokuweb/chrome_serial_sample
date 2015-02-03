class @Serial

	connectionId = null

	constructor: (parms) ->
		for name, value of parms
			@[name] = value
		@getPorts()

	getPorts: ->
		chrome.serial.getDevices (ports) =>
			for i,value of ports
				port = value.path
				@select.appendChild new Option port, port
	  return

	startConnection: ->
		portName = @select.childNodes[@select.selectedIndex].value
		config =
			bitrate : @bitrate
			dataBits : @dataBits
			parityBit : @parityBit
			stopBits : @stopBits

		chrome.serial.connect portName, config, (openInfo) ->
			connectionId = openInfo.connectionId
			console.log "connectionId = " + connectionId
			return
		return

	endConnection: ->
		chrome.serial.disconnect connectionId, (result) ->

	startRecieve: ->
		console.log "recieve start!!"
		chrome.serial.onReceive.addListener @getData

	getData: (readInfo) =>
		data = new Uint8Array readInfo.data
		@recieveCallback(data)

	sendData: (message) ->
  	buffer = new ArrayBuffer(message.length)
  	array = new Uint8Array(buffer)
  	for value, i in message
  		array[i] = value
  	chrome.serial.send connectionId, buffer, (sendInfo) =>
  		@sendCallback sendInfo