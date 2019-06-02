var msgpack = require("@msgpack/msgpack");

var CHUNK_SIZE = 65536;

function uint8ArrayToString(arr) {
  if (arr.length < CHUNK_SIZE) {
    return String.fromCharCode.apply(null, arr);
  }

  var result = "";
  var arrLen = arr.length;
  for (var i = 0; i < arrLen; i++) {
    var chunk = arr.subarray(i * CHUNK_SIZE, (i + 1) * CHUNK_SIZE);
    result += String.fromCharCode.apply(null, chunk);
  }
  return result;
}

function stringToUint8Array(str) {
  var buf = new ArrayBuffer(str.length);
  var arr = new Uint8Array(buf);
  var strLen = str.length;
  for (var i = 0; i < strLen; i++) {
    arr[i] = str.charCodeAt(i);
  }
  return arr;
}

var decode = function(left, right, arr) {
  try {
    return right(msgpack.decode(arr));
  } catch (e) {
    return left(e);
  }
};

exports.encode_ = msgpack.encode;

exports.encodeToString_ = function(json) {
  return uint8ArrayToString(msgpack.encode(json));
};

exports.decode_ = decode;

exports.decodeString_ = function(left, right, str) {
  var arr = stringToUint8Array(str);
  return decode(left, right, arr);
};
