---
title: TypeScript
---

## [仕事ですぐに使えるTypeScript](https://future-architect.github.io/typescript-guide/)

## [サバイバルTypeScrip](https://typescriptbook.jp/)

## [JavaScript Primer](https://jsprimer.net/)

## [ライブラリを探すやつ](https://www.typescriptlang.org/dt/search?search=)

## [Utility Type](https://www.typescriptlang.org/docs/handbook/utility-types.html)

## [TypeChallenge](https://github.com/type-challenges/type-challenges#challenges)

## [typesync](https://www.npmjs.com/package/typesync) && [ncu](https://www.npmjs.com/package/npm-check-updates)

- `typesync` ... `dependencies` にあるパッケージの `@types` を探して `devDependencies` に入れてくるやつ
- `ncu` ... 依存ライブラリの新しいバージョンを探して `package.json` を更新してくれるやつ

```sh
npx typesync && npx npm-check-updates -u && yarn
npx typesync && npx npm-check-updates -u && npm i
```

<https://github.com/millsp/ts-toolbelt>

## 依存のリスト化

```sh
cat (fd package.json) | jq -rs 'map((.dependencies // {}) * (.devDependencies // {}) | to_entries | .[] | .key) | unique | sort | .[]'
```

## bundle

### <https://github.com/microsoft/TypeScript>

### <https://github.com/evanw/esbuild>

ファイル変更検知してビルド + `node` コマンドで実行。
型チェックはされない。

```sh
esbuild src/index.ts --bundle --watch --platform=node --outfile=dist/index.js
node dist/index.js
```

### <https://github.com/swc-project/swc>

ファイル変更検知してビルド + `node` コマンドで実行。
型チェックはされない。
`-w` は `chokidar` に依存する。

```sh
swc src/index.ts -o dist/index.js -w
node dist/index.js
```

### <https://github.com/vercel/ncc>

`ncc` で直接実行 (型チェックをスキップして高速化)

```sh
ncc run src/index.ts --transpile-only
```

ファイル変更があったらビルド (型チェックをスキップして高速化) + `node` コマンドで実行

```sh
ncc build src/index.ts --transpile-only --watch
node dist/index.js
```

型チェックしてビルド

```sh
ncc build src/index.ts --minify
```

### <https://github.com/egoist/tsup>

利用例

- <https://github.com/vercel/turborepo>
- <https://github.com/jondot/hygen>
- <https://github.com/NotionX/react-notion-x>
- <https://github.com/marmelab/react-admin>
- <https://github.com/zpao/qrcode.react>

`--watch` でファイルの変更を検知してコンパイルを実行し、 `--onSuccess` でコンパイル成功後に任意のコマンドを実行できるのが特徴的。

```sh
tsup src/index.ts --watch src/ --onSuccess 'node dist/index.js'
```

こんな感じのコマンドを `npm run dev` で実行できるようにしておくと便利。

`--env.API_KEY abcd1234` みたいなオプションを付けるとビルド時に環境変数を注入できる。

ライブラリも含めてバンドルして単一ファイルにすることは出来なさそう。
`tsup` でバンドルしたファイルをライブラリとして配布するのは有効だが、アプリケーションとして配布する場合は `node_modules` もあわせて配布する必要がある。

`--dts` オプションをつけると型チェックが行われる。

### <https://github.com/babel/babel>

### <https://github.com/webpack/webpack>

### <https://github.com/TypeStrong/ts-node>

### <https://github.com/wclr/ts-node-dev>

### <https://github.com/rollup/rollup>
