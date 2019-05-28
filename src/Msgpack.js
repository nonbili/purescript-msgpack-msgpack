var msgpack = require("@msgpack/msgpack");
var msgpackU = require("@msgpack/msgpack/dist/utils/utf8");

exports.encode_ = msgpack.encode;

exports.encodeToString_ = function(json) {
  return msgpackU.safeStringFromCharCode(msgpack.encode(json));
};

function stringToUint8Array(str) {
  var arr = str.split("").map(function(char) {
    return char.charCodeAt(0);
  });
  return new Uint8Array(arr);
}

var decode = function(left, right, arr) {
  try {
    return right(msgpack.decode(arr));
  } catch (e) {
    return left(e);
  }
};

exports.decode_ = decode;

exports.decodeString_ = function(left, right, str) {
  var arr = stringToUint8Array(str);
  return decode(left, right, arr);
};
