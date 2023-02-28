import http from "k6/http";
import { check } from "k6";

export const options = {
  scenarios: {
    stress: {
      executor: "ramping-arrival-rate",
      preAllocatedVUs: 500,
      timeUnit: "1s",
      stages: [
        { duration: "10s", target: 100 }, // It will take 10 sec to go from 0 users to 100 users
        { duration: "10s", target: 200 }, // It will take 10 sec to go from 100 users to 200 users
        { duration: "15s", target: 400 },
        { duration: "30s", target: 500 },
        { duration: "30s", target: 0 }, // It will take 30 sec to go from 500 users to 0 users
      ],
    },
  },
};

export default function () {
  const BASE_URL =
    "http://aaef9e28ff0c9496bad616fc8322b6a6-21573471.us-east-1.elb.amazonaws.com";
  const res = http.get(`${BASE_URL}/api/score`);
  check(res, {
    "is status 200": (r) => r.status === 200,
  });
}
