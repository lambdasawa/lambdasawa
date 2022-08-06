# go-chromecast

<https://github.com/vishen/go-chromecast>

```sh
$ go-chromecast httpserver
INFO[0000] starting http server on 0.0.0.0:8011
```

## fetch device id

```sh
http ":8011/devices" | jq -r '.[] | select(.device_name | test("Chromecast")) | .uuid'
```

## connect to chromecast

```sh
http POST ":8011/connect?uuid="$(http ":8011/devices" | jq -r '.[] | select(.device_name | test("Chromecast")) | .uuid')
```

## show public url

```sh
http POST $(printf ":8011/load?uuid=%s&path=%s" \
  $(http ":8011/devices" | jq -r '.[] | select(.device_name | test("Chromecast")) | .uuid') \
  $(echo -n 'https://dummyimage.com/600x400/000/ff8c00.png&text=foo' | jq -Rr '@uri')
)
```

## show local file

```sh
http POST $(printf ":8011/load?uuid=%s&path=%s" \
  $(http ":8011/devices" | jq -r '.[] | select(.device_name | test("Chromecast")) | .uuid') \
  $(realpath ~/tmp/movies/test.mp4 | jq -Rr '@uri')
)
```
