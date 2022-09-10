IMAGE := "lamb-sbx-yt-dlp"

URL := "https://www.youtube.com/watch?v=FrcR9qvjwmo"

.PHONY: build
build:
	docker build -t ${IMAGE} .

.PHONY: download
download: build
	docker run --rm -v ${PWD}/opt/:/opt/ ${IMAGE} yt-dlp ${URL}
