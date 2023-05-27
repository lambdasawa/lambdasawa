---
title: tesseract
---

<https://tesseract-ocr.github.io/tessdoc/Installation.html#homebrew>

```sh
$ tesseract --list-langs
List of available languages in "/opt/homebrew/share/tessdata/" (3):
eng
osd
snum


$ brew list tesseract
/opt/homebrew/Cellar/tesseract/5.2.0/bin/tesseract
/opt/homebrew/Cellar/tesseract/5.2.0/include/tesseract/ (12 files)
/opt/homebrew/Cellar/tesseract/5.2.0/lib/libtesseract.5.dylib
/opt/homebrew/Cellar/tesseract/5.2.0/lib/pkgconfig/tesseract.pc
/opt/homebrew/Cellar/tesseract/5.2.0/lib/ (2 other files)
/opt/homebrew/Cellar/tesseract/5.2.0/share/tessdata/ (35 files)


$ ls -alh /opt/homebrew/Cellar/tesseract/5.2.0/share/tessdata/
total 45224
drwxr-xr-x   8 lambdasawa  admin   256B  7  7 05:15 ./
drwxr-xr-x   3 lambdasawa  admin    96B  7  7 05:15 ../
drwxr-xr-x  27 lambdasawa  admin   864B  7  7 05:15 configs/
-rw-r--r--   1 lambdasawa  admin   3.9M  7  7 05:15 eng.traineddata
-rw-r--r--   1 lambdasawa  admin    10M  7  7 05:15 osd.traineddata
-rw-r--r--   1 lambdasawa  admin   572B  7  7 05:15 pdf.ttf
-rw-r--r--   1 lambdasawa  admin   8.1M  7  7 05:15 snum.traineddata
drwxr-xr-x   8 lambdasawa  admin   256B  7  7 05:15 tessconfigs/


$ curl -sSLO http://archive.ubuntu.com/ubuntu/pool/universe/t/tesseract-lang/tesseract-lang_4.00~git30-7274cfa.orig.tar.xz
$ tar Jxfv tesseract-lang_4.00\~git30-7274cfa.orig.tar.xz
$ cp tesseract-lang-4.00\~git30-7274cfa/jpn.traineddata /opt/homebrew/Cellar/tesseract/5.2.0/share/tessdata/
$ tesseract --list-langs
List of available languages in "/opt/homebrew/share/tessdata/" (4):
eng
jpn
osd
snum

$ tesseract input-file-name.png - -l jpn
```
