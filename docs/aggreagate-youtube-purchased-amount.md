# Aggaregate YouTube purchased amount

https://www.youtube.com/paid_memberships

```js
[...document.querySelectorAll(".style-scope.yt-card-item-text-renderer")]
  .map(e => e.textContent)
  .filter(s => s.startsWith("￥"))
  .map(s => Number(s.replace("￥", "").replace(",", "")))
  .reduce((a, b) => a + b, 0)
```
