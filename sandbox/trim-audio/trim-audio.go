package main

import (
	"os"
	"time"

	"github.com/faiface/beep"
	"github.com/faiface/beep/wav"
)

var (
	fileName      = "in.wav"
	outFileName   = "out.wav"
	startDuration = 60 * time.Second
	duration      = 5 * time.Second
)

func main() {
	if err := run(); err != nil {
		panic(err)
	}
}

func run() error {
	file, err := os.Open(fileName)
	if err != nil {
		return err
	}

	streamer, format, err := wav.Decode(file)
	if err != nil {
		return err
	}
	defer streamer.Close()

	if err := streamer.Seek(format.SampleRate.N(startDuration)); err != nil {
		return err
	}

	s := beep.Take(format.SampleRate.N(duration), streamer)

	outFile, err := os.OpenFile(outFileName, os.O_WRONLY|os.O_CREATE, 0644)
	if err != nil {
		return err
	}
	defer outFile.Close()

	if err := wav.Encode(outFile, s, format); err != nil {
		return err
	}

	return nil
}
