console.log(
  require("fs")
    .readFileSync("input.txt")
    .toString("utf-8")
    .split("\n")
    .map((line) => line.match(/=([\d]+) (.+)/))
    .filter((v) => v)
    .map(([_, timestamp, text]) => ({ timestamp: Number(timestamp), text }))
    .map(
      ({ timestamp, text }) =>
        `${[Math.floor(timestamp / 3600), Math.floor((timestamp / 60) % 60), timestamp % 60]
          .map((n) => n + 100)
          .map((n) => n.toString().slice(-2))
          .join(":")} ${text}`
    )
    .join("\n")
);
