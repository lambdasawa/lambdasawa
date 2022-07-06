function exec(cmd) {
  alert(cmd);
  tri.native
    .run(cmd)
    .then((result) => {
      const msg = [`$ ${cmd}`, result.content, `Exit code: ${result.code}`].join("\n");
      alert(msg);
      console.log(msg);
    })
    .catch((e) => {
      alert(cmd, e);
      console.error(cmd, e);
    });
}

exec(`cd ~/Downloads && /opt/homebrew/bin/youtube-dl -f mp4 ${location.href}`);
