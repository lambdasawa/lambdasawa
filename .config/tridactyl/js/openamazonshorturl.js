const isbn = [...document.querySelectorAll("li.rpi-carousel-attribute-card")]
  .map((e) =>
    e.textContent
      .split("\n")
      .filter((v) => v)
      .join("\n")
  )
  .find((s) => s.includes("ISBN-10"))
  ?.replace("ISBN-10\n", "");
const asin = [...document.querySelectorAll("#detailBullets_feature_div .a-list-item")]
  .map((e) => e.textContent.replace(/[\s:\u200b-\u200f]+/g, ""))
  .find((s) => s.startsWith("ASIN"))
  ?.replace("ASIN", "");
const url = `https://www.amazon.co.jp/dp/${isbn || asin}`;

window.open(url, "_blank");
