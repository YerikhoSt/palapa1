import 'dart:typed_data';
import 'package:cbor/cbor.dart';

class MsgReader {

  MsgReader();

  static CborValue readReceivedData(Uint8List list) {
    return cbor.decode(list);
  }

}
