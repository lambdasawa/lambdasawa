const encodedURL = encodeURIComponent(location.href);
const url = `https://feedly.com/i/discover/sources/search/feed/${encodedURL}`;
window.open(url, "_blank");
