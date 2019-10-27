const msgpack = require("@msgpack/msgpack");

const CHUNK_SIZE = 65536;

function uint8ArrayToString(arr) {
  if (arr.length < CHUNK_SIZE) {
    return String.fromCharCode.apply(null, arr);
  }

  const result = "";
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

exports.encode_ = json => {
  const encoded = msgpack.encode(json);
  return encoded.buffer.slice(encoded.byteOffset, encoded.byteLength);
};

exports.encodeToString_ = function(json) {
  return uint8ArrayToString(msgpack.encode(json));
};

exports.decode_ = left => right => buffer =>
  decode(left, right, new Uint8Array(buffer));

exports.decodeString_ = left => right => str => {
  const arr = stringToUint8Array(str);
  return decode(left, right, arr);
};
