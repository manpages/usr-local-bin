##############################ffmpeg/avconv Screencast script###################################################################################################################
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#packages needed: libavcodec-extra-xx libvorbis libx264-xx ffmpeg (ubuntu package names); libavc1394 ffmpeg gstreamer0.10-ffmpeg x264(arch packages)
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#PROTIP: add keyboard shortcuts for starting the script like: /your/script/location/cast.sh and stoping shortcut with the command: killall ffmpeg (or avconv if you using that)
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#script by Xpander
#Youtube Channel for Sample Videos: https://www.youtube.com/user/Xpander666
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#date function
DATE=`which date`

#mount ramdisk (uncomment and change if you want to use ramdisk - dont forget to change directory as well)
#gksu mount -t tmpfs -o size=3096M tmpfs /tmp/ramdisk/

#package select (avconv or ffmpeg)
RECORDER=ffmpeg
#How many threads used (0 for automatic)
THREADS=0
#Resolution
#RESO=1920x1080
FULLSCREEN="$(xrandr | grep "*+" | grep -oE "[0-9]+x[0-9]+")"
#Xserver Display number(:0.0 is default)
XDISP=:0.0
#Audio Device
AUDIO=alsa
#Channels
CHANNELS=2
#SoundCard (pulse for pulseaudio, hw:0,1 for directly communicating with your soundcard - use aplay -l to see whats your value)
SOUNDCARD=pulse
#Frames per second
FPS=30
#Constant Rate Factor(0 is the highest quality 50 is the lowest)
CRF=22
#libx264 presets(slow, fast, superfast, ultrafast; additionaly check sudo find /usr -iname '*.ffpreset' for more)
PRESET=ultrafast
#Audio Codec (libmp3lame, pcm_s16le or libvorbis are most common)
ACODEC=libvorbis
#Directory where your video is gonna be saved.(include / at the end)
DIRECTORY=$HOME/Videos/
#File name
FILENAME=audiocast`$DATE +%d%m%Y_%H.%M.%S`.ogg

#script
notify-send -t 1000 'FFmpeg Recording' 'Recording has started!'
aplay /usr/share/sounds/alsa/Rear_Center.wav
$RECORDER -f $AUDIO -ac $CHANNELS -i $SOUNDCARD -threads $THREADS $DIRECTORY$FILENAME
notify-send -t 1000 'FFmpeg Recording' 'Recording has stopped!'


#old examples
##sample:ffmpeg -f alsa -ac 2 -i hw:0,1 -f x11grab -r 30 -s 1280x1024 -i :0.0 -acodec pcm_s16le -vcodec libx264 -vpre lossless_ultrafast -threads 0 output.avi
#sample2:avconv -f alsa -i pulse -f x11grab -r 25 -s 1920x1080 -i :0.0 -vcodec mpeg4 -b 12000k -g 300 -bf 2 -acodec libmp3lame -ab 256k Screencast.avi
#sample3:ffmpeg -threads 0 -f alsa -i pulse -f x11grab -s 1280x720 -r 30 -i :0.0+0,0 -vcodec libx264 -preset superfast -crf 16 -acodec libmp3lame -ab 256k -ar 44100 -f mp4 screencast.mp4
