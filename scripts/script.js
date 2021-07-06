import http from 'k6/http';

export default function () {
  let res = http.get('http://143.110.228.93:9292/');
  check(res, {
    '200': (r) => r.status === 200,
  });
}