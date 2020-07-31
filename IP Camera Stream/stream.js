const ffmpeg = require('ffmpeg');
const Stream = require('node-rtsp-stream')
const stream = new Stream({
  name: 'name',
  streamUrl: 'rtsp://169.254.29.185:554/Streaming/Channels/101?transportmode=unicast&profile=Profile_1',
  wsPort: 9999,
  ffmpegOptions: { // options ffmpeg flags
    '-stats': '', // an option with no neccessary value uses a blank string
    '-r': 30 // options with required values specify the value after the key
  }
})