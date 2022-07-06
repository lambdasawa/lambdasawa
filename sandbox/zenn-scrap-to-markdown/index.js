fetch(`https://zenn.dev/api/scraps/${location.href.split("scraps/")[1]}/blob.json`)
  .then((res) => res.json())
  .then((res) =>
    res.comments
      .map((c) => [c.body_markdown || "", c?.children?.map((child) => child.body_markdown).join("\n\n")].join("\n\n"))
      .join("\n\n")
  )
  .then(console.log);
