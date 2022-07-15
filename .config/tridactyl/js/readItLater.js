const title = encodeURIComponent(document.title);
const body = encodeURIComponent(location.href);

window.open(
  `https://github.com/lambdasawa/lambdasawa/issues/new?title=${title}&body=${body}&assignee=lambdasawa&labels=read-it-later`,
  "_blank"
);
