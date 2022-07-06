text = decodeURIComponent(
  location.hash
    .replace("#:~:text=", "")
    .split(",")
    .find((s) => !s.startsWith("-") && !s.endsWith("-"))
);

function findTargets(element, parent, text, level = 0) {
  if (element.childNodes.length === 0) {
    return element.textContent.includes(text) ? { element, parent, level } : null;
  } else {
    return [...element.childNodes].flatMap((e) => findTargets(e, element, text, level + 1)).filter((target) => target);
  }
}

target = findTargets(document.body, null, text).sort((a, b) => b.level - a.level)?.[0];

target.parent.scrollIntoView();

range = document.createRange();
startOffset = target.element.textContent.indexOf(text);
range.setStart(target.element, startOffset);
range.setEnd(target.element, startOffset + text.length);
window.getSelection().addRange(range);
