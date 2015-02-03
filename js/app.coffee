$comOpenButton = $('#com-open')
$comCloseButton = $('#com-close')
$sendButton = $('#send')

$comOpenButton.click (event) ->
  serial.startConnection()
  serial.startRecieve()

$comCloseButton.click (event) ->
  serial.endConnection()

$sendButton.click (event) ->
  message = ["0x01, 0x02, 0x03, 0x04, 0x05"]
  serial.sendData(message)

recieveCallback = (data) ->
  console.log "recieve data!!"
  console.log data

sentCallback  = (info) ->
  console.log "send!!"

serialConfig =
  select : document.getElementById 'ports' # ポート名を表示するselect要素ID名
  bitrate : 9600                           # ボーレート
  dataBits : "eight"                       # データ数
  parityBit : "no"                         # パリティビット
  stopBits : "one"                         # ストップビット
  recieveCallback : recieveCallback        # データ受信完了時コールバック関数
  sendCallback : sentCallback              # データ送信完了時コールバック関数

serial = new Serial serialConfig