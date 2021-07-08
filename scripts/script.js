import { check } from 'k6';
import http from 'k6/http';

export default function () {
  let res = http.get(`http://${ __ENV.APP_HOST_IP }:9292/`);
  check(res, {
    '200': (r) => r.status === 200,
  });
}