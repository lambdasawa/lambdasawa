from yt_dlp import YoutubeDL

URLS = ['https://www.youtube.com/watch?v=MS2iG2hlhlY']

yt_dlp_opts = {
  'outtmpl': 'data/%(id)s.%(ext)s',
  'format': 'm4a/bestaudio/best',
  'postprocessors': [
    {
      'key': 'FFmpegExtractAudio',
      'preferredcodec': 'mp3',
    }
  ],
}

with YoutubeDL(yt_dlp_opts) as ydl:
  ydl.download(URLS)
