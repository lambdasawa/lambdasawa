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

const uri = document.location.href.replace(/https:\/\/github.com\/([^\/]+)\/([^\/]+)/, "git@github.com:$1/$2.git");

exec(`/opt/homebrew/bin/ghq get ${uri}`);
