(function() {
if (!window.MediaSource) {
  console.log("The Media Source Extensions API is not supported.");
  return;
}

const mediaSource = new MediaSource();
const media = document.getElementById('media');
media.src = URL.createObjectURL(mediaSource);
mediaSource.addEventListener('sourceopen', sourceOpen);

function sourceOpen(e) {
  URL.revokeObjectURL(media.src);
  var mediaSource = e.target;
  var sourceBuffer = mediaSource.addSourceBuffer(resource.type);
  fetch(resource.url)
    .then(function(response) {
      return response.arrayBuffer();
    })
    .then(function(arrayBuffer) {
      sourceBuffer.addEventListener("updateend", function(e) {
        if (!sourceBuffer.updating && mediaSource.readyState === "open") {
          mediaSource.endOfStream();
        }
      });
      sourceBuffer.appendBuffer(arrayBuffer);
    });
}
})();
