#!/bin/bash
# GTA 6 easter eggs Short — render script v2, built in-session 20 Nov 2026.
# 13 parts (1080x1920, 30fps) -> concat -> VO + trailer-audio bed -> final mp4.
# Total: 54.72s. All timestamps verified from footage (see report).
# v2 fixes: T2 is letterboxed (cropdetect 1920:864:0:108) — de-letterboxed in
# every T2 part; Joker freeze re-framed on his face; billboard video shortened
# to the window where the billboard is actually visible; PS5 zoom retargeted
# tighter on the console; still segments get a blurred-fill background.
set -e
cd /home/hatch/workspace/makefun/gta6-clipper-01/footage
mkdir -p ../segments
FONT=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf
ENC="-c:v libx264 -crf 20 -preset medium -pix_fmt yuv420p -r 30 -fps_mode cfr -an"

# --- P01 hook (5.17s): Phil ad freeze, slow zoom, big yellow text ---
ffmpeg -y -v error -loop 1 -i still_phil_ad.png -vf "crop=1920:864:0:108,zoompan=z='1+0.0008*on':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=155:s=1920x864:fps=30,crop=486:864:827:0,scale=1080:1920,drawtext=fontfile=$FONT:text='ROCKSTAR HID A':fontcolor=yellow:fontsize=84:borderw=5:bordercolor=black:x=(w-text_w)/2:y=1280,drawtext=fontfile=$FONT:text='2002 CHARACTER':fontcolor=yellow:fontsize=84:borderw=5:bordercolor=black:x=(w-text_w)/2:y=1380,drawtext=fontfile=$FONT:text='IN GTA 6...':fontcolor=yellow:fontsize=84:borderw=5:bordercolor=black:x=(w-text_w)/2:y=1480" -frames:v 155 $ENC ../segments/p01_hook.mp4
echo "p01 done"

# --- P02 Phil video (4.60s): T2 130.0-134.6 ---
ffmpeg -y -v error -ss 130 -i trailer2.mp4 -t 4.6 -vf "crop=486:864:827:108,scale=1080:1920,drawtext=fontfile=$FONT:text='PHIL CASSIDY IS BACK':fontcolor=white:fontsize=64:borderw=4:bordercolor=black:x=(w-text_w)/2:y=1550" $ENC ../segments/p02_phil.mp4
echo "p02 done"

# --- P03 VC art still (2.30s), blurred-fill background ---
ffmpeg -y -v error -loop 1 -i phil-vc-art.jpg -vf "zoompan=z='1+0.0008*on':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=69:s=800x600:fps=30,split[bg0][fg0];[bg0]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,gblur=sigma=40[bg];[fg0]scale=1080:810[fg];[bg][fg]overlay=0:555,drawtext=fontfile=$FONT:text='VICE CITY, 2002':fontcolor=white:fontsize=64:borderw=4:bordercolor=black:x=(w-text_w)/2:y=1550" -frames:v 69 $ENC ../segments/p03_vcart.mp4
echo "p03 done"

# --- P04 Phil zoom (2.33s): zoom into the TV ad ---
ffmpeg -y -v error -loop 1 -i still_phil_ad.png -vf "crop=1920:864:0:108,zoompan=z='1.3+0.002*on':x='1070-iw/zoom/2':y='max(0,192-ih/zoom/2)':d=70:s=1920x864:fps=30,crop=486:864:717:0,scale=1080:1920,drawtext=fontfile=$FONT:text='BOTH ARMS ARE BACK?!':fontcolor=yellow:fontsize=72:borderw=5:bordercolor=black:x=(w-text_w)/2:y=1550" -frames:v 70 $ENC ../segments/p04_philzoom.mp4
echo "p04 done"

# --- P05 Joker freeze (3.80s): T1 65s mugshot, framed on his face ---
ffmpeg -y -v error -loop 1 -i still_joker.png -vf "crop=1215:2160:2400:0,zoompan=z='1+0.0009*on':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=114:s=1215x2160:fps=30,scale=1080:1920,drawtext=fontfile=$FONT:text='THIS GUY IS REAL':fontcolor=yellow:fontsize=72:borderw=5:bordercolor=black:x=(w-text_w)/2:y=1450" -frames:v 114 $ENC ../segments/p05_joker.mp4
echo "p05 done"

# --- P06 side-by-side still (3.77s): real mugshot vs game character ---
ffmpeg -y -v error -loop 1 -i florida-joker-sidebyside.jpg -vf "zoompan=z='1+0.0006*on':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=113:s=620x348:fps=30,split[bg0][fg0];[bg0]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,gblur=sigma=40[bg];[fg0]scale=1080:607[fg];[bg][fg]overlay=0:656,drawtext=fontfile=$FONT:text='REAL MUGSHOT vs GTA 6':fontcolor=white:fontsize=56:borderw=4:bordercolor=black:x=(w-text_w)/2:y=420,drawtext=fontfile=$FONT:text='HE DEMANDED \$10 MILLION':fontcolor=yellow:fontsize=64:borderw=5:bordercolor=black:x=(w-text_w)/2:y=1420,drawtext=fontfile=$FONT:text='ROCKSTAR SAID NO':fontcolor=white:fontsize=56:borderw=4:bordercolor=black:x=(w-text_w)/2:y=1520" -frames:v 113 $ENC ../segments/p06_sidebyside.mp4
echo "p06 done"

# --- P07 roof video (2.20s): T2 11.47-13.67 ---
ffmpeg -y -v error -ss 11.47 -i trailer2.mp4 -t 2.2 -vf "crop=486:864:517:108,scale=1080:1920,drawtext=fontfile=$FONT:text='JUST FIXING SOME LEAKS':fontcolor=yellow:fontsize=64:borderw=5:bordercolor=black:x=(w-text_w)/2:y=1500" $ENC ../segments/p07_roof.mp4
echo "p07 done"

# --- P08 roof freeze (6.62s): Jason on the roof, slow zoom ---
ffmpeg -y -v error -loop 1 -i still_roof.png -vf "crop=1920:864:0:108,zoompan=z='1+0.0005*on':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=199:s=1920x864:fps=30,crop=486:864:517:0,scale=1080:1920,drawtext=fontfile=$FONT:text='JUST FIXING SOME LEAKS':fontcolor=yellow:fontsize=64:borderw=5:bordercolor=black:x=(w-text_w)/2:y=1500,drawtext=fontfile=$FONT:text='AFTER THE BIGGEST LEAK EVER':fontcolor=white:fontsize=52:borderw=4:bordercolor=black:x=(w-text_w)/2:y=1600" -frames:v 199 $ENC ../segments/p08_rooffreeze.mp4
echo "p08 done"

# --- P09 billboard video (0.93s): T1 60.47-61.40, the window where the
# billboard is actually visible (the camera pans onto Jason's head after) ---
ffmpeg -y -v error -ss 60.47 -i trailer1.webm -t 0.93 -vf "crop=1215:2160:150:0,scale=1080:1920,drawtext=fontfile=$FONT:text='IT CURES EMOTIONS?!':fontcolor=yellow:fontsize=72:borderw=5:bordercolor=black:x=(w-text_w)/2:y=1500" -frames:v 28 $ENC ../segments/p09_billboard.mp4
echo "p09 done"

# --- P10 billboard zoom (6.74s): pre-crop on the billboard, big + readable ---
ffmpeg -y -v error -loop 1 -i still_billboard.png -vf "crop=1600:1200:50:200,zoompan=z='1+0.0004*on':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=202:s=1600x1200:fps=30,split[bg0][fg0];[bg0]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,gblur=sigma=40[bg];[fg0]scale=1080:810[fg];[bg][fg]overlay=0:555,drawtext=fontfile=$FONT:text='BLINK AND YOU WILL MISS IT':fontcolor=white:fontsize=52:borderw=4:bordercolor=black:x=(w-text_w)/2:y=420,drawtext=fontfile=$FONT:text='IT CURES EMOTIONS?!':fontcolor=yellow:fontsize=72:borderw=5:bordercolor=black:x=(w-text_w)/2:y=1500,drawtext=fontfile=$FONT:text='ONLY IN LEONIDA':fontcolor=white:fontsize=52:borderw=4:bordercolor=black:x=(w-text_w)/2:y=1600" -frames:v 202 $ENC ../segments/p10_billboardzoom.mp4
echo "p10 done"

# --- P11 PS5 video (3.60s): T2 130.0-133.6, same shot as Phil ---
ffmpeg -y -v error -ss 130 -i trailer2.mp4 -t 3.6 -vf "crop=486:864:827:108,scale=1080:1920,drawtext=fontfile=$FONT:text='LOOK UNDER THE TV...':fontcolor=white:fontsize=64:borderw=4:bordercolor=black:x=(w-text_w)/2:y=1550" $ENC ../segments/p11_ps5.mp4
echo "p11 done"

# --- P12 PS5 zoom (3.66s): tight zoom onto the console under the TV ---
ffmpeg -y -v error -loop 1 -i still_phil_ad.png -vf "crop=1920:864:0:108,zoompan=z='1.9+0.003*on':x='740-iw/zoom/2':y='462-ih/zoom/2':d=110:s=1920x864:fps=30,crop=486:864:717:0,scale=1080:1920,drawtext=fontfile=$FONT:text='A REAL PLAYSTATION 5':fontcolor=yellow:fontsize=64:borderw=5:bordercolor=black:x=(w-text_w)/2:y=1500,drawtext=fontfile=$FONT:text='IN GTA 6':fontcolor=white:fontsize=56:borderw=4:bordercolor=black:x=(w-text_w)/2:y=1600" -frames:v 110 $ENC ../segments/p12_ps5zoom.mp4
echo "p12 done"

# --- P13 end card (9.00s): jet-ski bg, pitch 0-8s, subscribe 8-9s ---
ffmpeg -y -v error -loop 1 -i still_endcard.png -vf "crop=1920:864:0:108,zoompan=z='1+0.0004*on':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=270:s=1920x864:fps=30,crop=486:864:1007:0,scale=1080:1920,drawtext=fontfile=$FONT:text='I MADE THIS CLIP WITH AI':fontcolor=white:fontsize=64:borderw=4:bordercolor=black:box=1:boxcolor=black@0.55:boxborderw=20:x=(w-text_w)/2:y=700:enable='between(t,0,8)',drawtext=fontfile=$FONT:text='AND IT CAN EARN MONEY':fontcolor=white:fontsize=64:borderw=4:bordercolor=black:box=1:boxcolor=black@0.55:boxborderw=20:x=(w-text_w)/2:y=800:enable='between(t,0,8)',drawtext=fontfile=$FONT:text='make.fun/bounty/gta6-clipper-01':fontcolor=yellow:fontsize=46:borderw=4:bordercolor=black:box=1:boxcolor=black@0.55:boxborderw=20:x=(w-text_w)/2:y=1000:enable='between(t,0,8)',drawtext=fontfile=$FONT:text='MAKE CLIPS WITH AI. GET PAID.':fontcolor=white:fontsize=48:borderw=4:bordercolor=black:box=1:boxcolor=black@0.55:boxborderw=20:x=(w-text_w)/2:y=1150:enable='between(t,0,8)',drawtext=fontfile=$FONT:text='SUBSCRIBE FOR PART 2':fontcolor=yellow:fontsize=72:borderw=5:bordercolor=black:box=1:boxcolor=black@0.55:boxborderw=20:x=(w-text_w)/2:y=900:enable='between(t,8,9)'" -frames:v 270 $ENC ../segments/p13_endcard.mp4
echo "p13 done"

# --- Concat video parts ---
cd ../segments
for p in p01_hook p02_phil p03_vcart p04_philzoom p05_joker p06_sidebyside p07_roof p08_rooffreeze p09_billboard p10_billboardzoom p11_ps5 p12_ps5zoom p13_endcard; do echo "file '$p.mp4'"; done > list.txt
ffmpeg -y -v error -f concat -safe 0 -i list.txt -c copy ../video_novoice.mp4
echo "concat done"
ffprobe -v error -show_entries format=duration -of csv=p=0 ../video_novoice.mp4

# --- Audio: VO track (7 segments + 0.3s gaps, padded to 54.72s) ---
cd ..
ffmpeg -y -v error -f lavfi -i anullsrc=r=48000:cl=stereo -t 0.3 audio/sil03.m4a
ffmpeg -y -v error -i audio/vo_1.mp3 -i audio/sil03.m4a -i audio/vo_2.mp3 -i audio/sil03.m4a -i audio/vo_3.mp3 -i audio/sil03.m4a -i audio/vo_4.mp3 -i audio/sil03.m4a -i audio/vo_5.mp3 -i audio/sil03.m4a -i audio/vo_6.mp3 -i audio/sil03.m4a -i audio/vo_7.mp3 -filter_complex "[0:a]aresample=48000,aformat=sample_fmts=fltp:channel_layouts=stereo[v0];[1:a]aresample=48000,aformat=sample_fmts=fltp:channel_layouts=stereo[s0];[2:a]aresample=48000,aformat=sample_fmts=fltp:channel_layouts=stereo[v1];[3:a]aresample=48000,aformat=sample_fmts=fltp:channel_layouts=stereo[s1];[4:a]aresample=48000,aformat=sample_fmts=fltp:channel_layouts=stereo[v2];[5:a]aresample=48000,aformat=sample_fmts=fltp:channel_layouts=stereo[s2];[6:a]aresample=48000,aformat=sample_fmts=fltp:channel_layouts=stereo[v3];[7:a]aresample=48000,aformat=sample_fmts=fltp:channel_layouts=stereo[s3];[8:a]aresample=48000,aformat=sample_fmts=fltp:channel_layouts=stereo[v4];[9:a]aresample=48000,aformat=sample_fmts=fltp:channel_layouts=stereo[s4];[10:a]aresample=48000,aformat=sample_fmts=fltp:channel_layouts=stereo[v5];[11:a]aresample=48000,aformat=sample_fmts=fltp:channel_layouts=stereo[s5];[12:a]aresample=48000,aformat=sample_fmts=fltp:channel_layouts=stereo[v6];[v0][s0][v1][s1][v2][s2][v3][s3][v4][s4][v5][s5][v6]concat=n=13:v=0:a=1,apad=whole_dur=54.72" -c:a aac -b:a 192k audio/vo_track.m4a
# Mix with the T2 bed at 8% (NOTE: -map "[out]" is REQUIRED — without it ffmpeg
# auto-maps the trailer's video stream into the .m4a and the encode runs away).
ffmpeg -y -v error -i audio/vo_track.m4a -i footage/trailer2.mp4 -filter_complex "[1:a]atrim=0:54.72,volume=0.08[bed];[0:a][bed]amix=inputs=2:duration=first:normalize=0,loudnorm=I=-16:TP=-1.5:LRA=11:linear=true[out]" -map "[out]" -t 54.72 -c:a aac -b:a 192k audio/mix.m4a
echo "audio done"

# --- Mux ---
ffmpeg -y -v error -i video_novoice.mp4 -i audio/mix.m4a -map 0:v:0 -map 1:a:0 -c:v copy -c:a copy -shortest gta6-easter-eggs-short.mp4
echo "MUX DONE"
ffprobe -v error -show_entries format=duration,size -show_entries stream=width,height,codec_name -of default=noprint_wrappers=1 gta6-easter-eggs-short.mp4
