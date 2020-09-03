const msgpack = require("@msgpack/msgpack");

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

exports.encode_ = msgpack.encode;

exports.encodeToString_ = function(json) {
  return new TextDecoder("latin1").decode(msgpack.encode(json));
};

exports.decode_ = left => right => arr => decode(left, right, arr);

exports.decodeString_ = left => right => str => {
  const arr = stringToUint8Array(str);
  return decode(left, right, arr);
};
