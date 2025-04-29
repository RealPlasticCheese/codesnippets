REM This batch file will create a file on your local disk, and save a stream to disk
REM with a datestamp that orders correctly when you sort by name.
REM Requires curl to work - https://github.com/curl/curl

REM It will display the filename in the output and then use curl to save the stream to disk.

REM Example filenames -
REM 2024-03-28_08-50-10_kissfm.mp3
REM 2024-03-14_17-56-43_kissfm.mp3

REM Set the stream name (which is used to generate the saved file) and the streamURL and run it.
REM If the stream fails, it will automatically retry and create a new file
REM VLC is a recommended music player.  curl can still write to the file whilst VLC is playing it.

set streamName=kissfm.mp3
set streamUrl=http://149.56.185.83:8565/kissfm.mp3

:top
@echo off
REM Generate the datestamp for the filename
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%b-%%a)
set tmpTime=%TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%
For /f "tokens=1-3 delims=/:/ " %%a in ('echo %tmpTime: =0%') do (set mytime=%%a-%%b-%%c)
rem set mytime=%mytime: =% 
echo %mydate%_%mytime%_%streamName%
REM save the stream to disk -
curl %streamUrl% --output ./%mydate%_%mytime%_%streamName%
REM If the stream fails, it will start the process again

REM Add a delay of 5 seconds before re-running the loop
ping -n 6 127.0.0.1 >nul 2>&1
goto top
