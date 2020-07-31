
    //Camera Authentication
    //var ip_address = "169.254.29.185"
    //camera username and password
    var username = "admin";
    var password="RT$P$2020";

    //A channel of camera stream
    Stream = require('node-rtsp-stream');
    stream = new Stream({
        streamUrl: 'rtsp://' + username + ':' + password + '@' 
        + '169.254.29.185:554/Streaming/Channels/101?transportmode=unicast&profile=Profile_1' ,
        // rtsp://169.254.29.185:554/Streaming/Channels/101?transportmode=unicast&profile=Profile_1
        wsPort: 9999    
    });
