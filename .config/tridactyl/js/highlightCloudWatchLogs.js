console.log("highlightCloudWatchLogs.js");

setInterval(() => {
  console.log("highlightCloudWatchLogs.js interval...");

  const doc = document.getElementById("microConsole-Logs").contentWindow.document;

  [...doc.querySelectorAll(".awsui-table-row")].forEach((e) => {
    text = e.textContent;

    if (text.includes("\tERROR\t")) {
      e.style.backgroundColor = "#f88";
    }

    [
      ".logs__log-events-table__content",
      ".logs__events__json-key",
      ".logs__events__json-string",
      ".logs__events__json-number",
      ".logs__events__json-boolean",
    ].forEach((selector) => {
      [...doc.querySelectorAll(selector)].forEach((e) => {
        e.style.color = "#222";
      });
    });
  });
}, 5 * 1000);
