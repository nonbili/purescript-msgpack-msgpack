import msgpack from "@msgpack/msgpack";

const CHUNK_SIZE = 65536;

function uint8ArrayToString(arr) {
  if (arr.length < CHUNK_SIZE) {
    return String.fromCharCode.apply(null, arr);
  }

  let result = "";
  const arrLen = arr.length;
  for (let i = 0; i < arrLen; i++) {
    const chunk = arr.subarray(i * CHUNK_SIZE, (i + 1) * CHUNK_SIZE);
    result += String.fromCharCode.apply(null, chunk);
  }
  return result;
}

function stringToUint8Array(str) {
  const buf = new ArrayBuffer(str.length);
  const arr = new Uint8Array(buf);
  const strLen = str.length;
  for (let i = 0; i < strLen; i++) {
    arr[i] = str.charCodeAt(i);
  }
  return arr;
}

function decode(left, right, arr) {
  try {
    return right(msgpack.decode(arr));
  } catch (e) {
    return left(e);
  }
}

export let encode_ = msgpack.encode;

export function encodeToString_(json) {
  return uint8ArrayToString(msgpack.encode(json));
};

export let decode_ = left => right => arr => decode(left, right, arr);

export let decodeString_ = left => right => str => {
  const arr = stringToUint8Array(str);
  return decode(left, right, arr);
};
