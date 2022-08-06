const { chromium } = require("playwright");

async function main() {
  const browser = await chromium.launch();
  const context = await browser.newContext();
  const page = await context.newPage();
  await page.goto("https://www.lambdasawa.dev/");
  await page.screenshot({ path: "screenshot.png" });
}

exports.handler = async (event, context) => {
  await main();
};

if (!process.env.AWS_LAMBDA_FUNCTION_NAME) {
  main()
    .then(() => {
      console.log("Success");
      process.exit(0);
    })
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
}
