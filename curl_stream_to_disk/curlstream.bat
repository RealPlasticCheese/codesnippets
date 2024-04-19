# This batch file will create a file on your local disk, and save a stream to disk
# with a datestamp that orders correctly when you sort by name.
# Requires curl to work - https://github.com/curl/curl

# It will display the filename in the output and then use curl to save the stream to disk.

# Example filenames -
# 2024-03-28_08-50-10_kissfm.mp3
# 2024-03-14_17-56-43_kissfm.mp3

# Set the stream name (which is used to generate the saved file) and the streamURL and run it.
# If the stream fails, it will automatically retry and create a new file
# VLC is a recommended music player.  curl can still write to the file whilst VLC is playing it.

set streamName=kissfm.mp3
set streamUrl=http://149.56.185.83:8565/kissfm.mp3

:top
@echo off
# Generate the datestamp for the filename
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%b-%%a)
set tmpTime=%TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%
For /f "tokens=1-3 delims=/:/ " %%a in ('echo %tmpTime: =0%') do (set mytime=%%a-%%b-%%c)
rem set mytime=%mytime: =% 
echo %mydate%_%mytime%_%streamName%
# save the stream to disk -
curl %streamUrl% --output ./%mydate%_%mytime%_%streamName%
# If the stream fails, it will start the process again

# Add a delay of 5 seconds before re-running the loop
ping -n 6 127.0.0.1 >nul 2>&1
goto top
