import { check } from "k6";
import http from "k6/http";

const url = `https://${__ENV.TF_OUTPUT_apprunner_url}/hello`;

export default function () {
  const res = http.get(url);
  check(res, {
    "is status 200": (r) => r.status === 200,
  });
}
