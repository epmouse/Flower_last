import 'dart:convert';
import 'package:crypto/crypto.dart';

// ignore: implementation_imports
import 'package:crypto/src/digest_sink.dart';

class Crypto {
  static String hashBySha1(String salt, String key) {
    var firstChunk = utf8.encode(salt);
    var secondChunk = utf8.encode(key);
    var ds = new DigestSink();
    var s = sha1.startChunkedConversion(ds);
    s.add(firstChunk);
    s.add(secondChunk); // call `add` for every chunk of input data
    s.close();
    var digest = ds.value;
    return digest.toString();
  }
}
