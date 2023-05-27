import { chromium } from "playwright";

async function main() {
  const browser = await chromium.launch({});

  const page = await browser.newPage();

  await page.goto("https://example.com/");

  console.log(await page.locator("h1").first().innerText());

  await browser.close();
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
