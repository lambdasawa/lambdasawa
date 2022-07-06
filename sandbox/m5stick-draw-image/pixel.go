package main

import (
	"encoding/csv"
	"fmt"
	"os"
)

func main() {
	colorTableFile, err := os.Open("color-table.csv")
	if err != nil {
		panic(err)
	}
	defer colorTableFile.Close()

	colorTableCSV := csv.NewReader(colorTableFile)
	colorTable, err := colorTableCSV.ReadAll()
	if err != nil {
		panic(err)
	}

	colorMap := map[string]string{}
	for _, color := range colorTable {
		colorMap[color[0]] = color[1]
	}

	dotTableFile, err := os.Open("dot-table.csv")
	if err != nil {
		panic(err)
	}
	defer colorTableFile.Close()

	dotTableCSV := csv.NewReader(dotTableFile)
	dotTable, err := dotTableCSV.ReadAll()
	if err != nil {
		panic(err)
	}

	for y := range dotTable {
		for x := range dotTable[y] {
			color := colorMap[dotTable[y][x]]
			fmt.Printf("M5.Lcd.drawPixel(%d, %d, convert24bitTo16bitColor(0x%s));\n", x, y, color)
		}
	}
}
