# Steaming IP Camera Nodejs


## Getting Started

These instructions will get you a copy of the project to make it up and running on your local machine for development and testing purposes.

### Prerequisites

What things you need to install the software and how to install them

* [Git](https://git-scm.com/downloads) - free and open source distributed version control system 
* [Node.js](https://nodejs.org/en/) - Node.js >= 10.15.0
* [FFmpeg](https://ffmpeg.zeranoe.com/builds/) - Multimedia framework to decode, encode, transcode, mux, demux, stream, filter and play

### Installing

A step by step series of examples that tell you how to get a development up and running

1. Download Git
* [Git](https://git-scm.com/downloads)
2. Open <strong>command prompt/terminal</strong>, Clone this repository to your local machine
```
git clone https://github.com/xpcrts/Steaming-IP-Camera-Nodejs
```
3. Download and install Node.js on your local machine
* [Node.js](https://nodejs.org/en/) - Node.js >= 10.15.0
4. Download and install pre-build FFMPEG Builds on your local machine (Download Build)
* [FFmpeg](https://ffmpeg.zeranoe.com/builds/) - Multimedia framework to decode, encode, transcode, mux, demux, stream, filter and play<br />
* Copy the FFMPEG Zip folder you have just downloaded, paste it into C: drive for simplicity and unzip it.
* Rename the file to <strong>ffmpeg</strong> for simpicity
* After unzipped the file, navigate ffmpeg/bin <br/>
#### On Microsoft Windows
You need to add ffmpeg to <strong>system variables</strong> (For all users) or <strong>User variables</strong> (For specific user)<br />
For research and test, I recommend to add the ffmpeg path to the <strong>system variables</strong> to do that just navigate to:<br/>
a. Control Panel<br/>
b. System and Security<br/>
c. System <br/>
d. Advanced system settings<br/>
e. Environment Variables...<br/>
f. System variables<br/>
g. Path (Double-click on it)<br/>
h. New<br/>
i. Paste this
```C:\ffmpeg\bin```<br/>
j. OK (3 times)<br /><br/>
5. NPM install node-onvif
```
npm install node-onvif -s
```
6.NPM install node-rtsp-stream<br/>
```
npm i node-rtsp-stream -s
```
7.NPM install http-server<br/>
```
npm install http-server -g
```

## Running the tests

1. In the repository, open <i>app.js</i> file
* Change IP address to your camera IP address
* Username of your network camera
* Password of your network camera<br/>
2. Open one command prompt/terminal, navigate to <strong>Streaming-IP-Camera-Nodejs/src</strong> directory and type:
```
http-server
```
hit enter to run<br /><br/>
3. Open another command prompt/terminal, on the same directory path and type: 
```
node app.js
```
hit enter to run<br /><br/>
Now keep those two terminal up and running<br/><br/>
<strong>Preview Streaming Camera on web browser by go to this URL:<br/></strong>
> [127.0.0.1:8000](http://127.0.0.1:8080/)<br/>

You are ready to go.

## To-dos

* Streaming Multiple camera channels at once, using 4x4 grid or more
* Customize width and height of canvas
* Improve streaming resolution quality
* Decrease streaming latency 

## Authors

**Muhammad Saariya ** - [MuhammadSaariya](https://github.com/MuhammadSaariya)

