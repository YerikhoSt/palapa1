import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cbor/cbor.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:palapa1/utils/change_prefs.dart';
import 'package:palapa1/utils/config.dart';
import 'package:palapa1/utils/msg_reader.dart';
import 'package:palapa1/widgets/toast_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

Future<Uint8List> fetchDataCbor(
  String url, {
  FetchDataMethod method = FetchDataMethod.get,
  TokenLabel tokenLabel = TokenLabel.xa,
  String? tokenString,
  int timeoutInSecond = 30,
  Map<String, String> extraHeader = const <String, String>{},
  String rtoMessage = 'Request Timeout',
  String? errorMessage,
  String noConnectionMessage = 'No Connection Detected',
  bool showToastWhenRto = true,
  bool showToastWhenNoConnection = true,
  Map<String, dynamic> params = const <String, dynamic>{},
  List<String>? paramsDelete = const <String>[],
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final http.Client client = http.Client();
  try {
    //default header
    final Map<String, String> _headers = <String, String>{
      'Accept': 'application/cbor',
      'Content-Type': 'application/cbor',
      if (tokenLabel != TokenLabel.none)
        tokenLabel == TokenLabel.xa ? 'XA' : 'token-id':
            tokenString ?? prefs.getString('token').toString()
    };

    //adding extra header if exist
    _headers.addAll(extraHeader);

    //functions to request to endpoint
    Future<http.Response> _getResponse(Map<String, String>? _h) async {
      if (method == FetchDataMethod.put) {
        return client
            .put(
              Uri.parse('${Config.domain}$url'),
              headers: _h ?? _headers,
              body: cbor.encode(CborValue(params)),
            )
            .timeout(Duration(seconds: timeoutInSecond));
      } else if (method == FetchDataMethod.post) {
        return client
            .post(
              Uri.parse('${Config.domain}$url'),
              headers: _h ?? _headers,
              body: cbor.encode(CborValue(params)),
            )
            .timeout(Duration(seconds: timeoutInSecond));
      } else if (method == FetchDataMethod.delete) {
        return client
            .delete(
              Uri.parse('${Config.domain}$url'),
              headers: _h ?? _headers,
              body: cbor.encode(CborValue(paramsDelete)),
            )
            .timeout(Duration(seconds: timeoutInSecond));
      } else {
        return client
            .get(
              Uri.parse('${Config.domain}$url'),
              headers: _h ?? _headers,
            )
            .timeout(Duration(seconds: timeoutInSecond));
      }
    }

    // //do request to endpoint
    final http.Response response = await _getResponse(null);

    /// 'statusCode' possible value
    /// 200 : sukses
    /// 400 : error
    /// >200 : error
    if (response.statusCode == 200) {
      //Close request after endpoint send callback
      client.close();

      return response.bodyBytes;
    } else {
      if (response.statusCode == 400) {
        final Map<String, dynamic>? value =
            MsgReader.readReceivedData(response.bodyBytes).toJson()
                as Map<String, dynamic>?;
        final CborValue _socketCb = CborValue(<String, dynamic>{
          'status': -1,
          'message': errorMessage ?? value!['message']
        });
        return Uint8List.fromList(cbor.encode(_socketCb));
      } else {
        await getPrefsProfile().then((Map<String, dynamic> v) async {
          await fetchDataCbor(
            'auth/login_mobile',
            tokenLabel: TokenLabel.none,
            method: FetchDataMethod.post,
            extraHeader: <String, String>{
              'uspw': jsonEncode(<String, dynamic>{
                'user': v['user_email'] ?? '',
                'pass': v['user_password'] ?? '',
              }),
            },
          ).then((Uint8List list) async {
            final Map<String, dynamic>? value = MsgReader.readReceivedData(list)
                .toJson() as Map<String, dynamic>?;
            if (value!.containsKey('token') == true) {
              await changePrefsLogin(<String, String>{
                'email': v['user_email'] ?? '',
                'password': v['user_password'] ?? '',
                'token': value['token'] as String
              });
            }
          });
        });

        final http.Response response = await _getResponse(<String, String>{
          'Accept': 'application/cbor',
          'Content-Type': 'application/cbor',
          if (tokenLabel != TokenLabel.none)
            tokenLabel == TokenLabel.xa ? 'XA' : 'token-id':
                tokenString ?? prefs.getString('token').toString()
        });

        //Close request after endpoint send callback
        client.close();

        return response.bodyBytes;
      }
    }
  } on TimeoutException {
    //Triggered when timeout
    if (showToastWhenRto) showToast(rtoMessage);
    final CborValue _rtoCb =
        CborValue(<String, dynamic>{'status': -1, 'message': rtoMessage});
    return Uint8List.fromList(cbor.encode(_rtoCb));
  } on SocketException {
    //Triggered hen no internet connection
    if (showToastWhenNoConnection) showToast(noConnectionMessage);
    final CborValue _socketCb = CborValue(
        <String, dynamic>{'status': -1, 'message': noConnectionMessage});
    return Uint8List.fromList(cbor.encode(_socketCb));
  }
}

Future<Uint8List> uploadImageCbor(List<File> files) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final http.MultipartRequest request = http.MultipartRequest(
      'POST', Uri.parse('${Config.domain}dms/uploadfile'));

  request.headers['Accept'] = 'application/cbor';
  request.headers['Content-Type'] = 'application/cbo';
  request.headers['XA'] = prefs.getString('token') ?? '';

  for (final File i in files) {
    final String? mimeType = lookupMimeType(i.path);
    request.files.add(
      http.MultipartFile(
        'upload',
        i.readAsBytes().asStream(),
        i.lengthSync(),
        filename: basename(i.path),
        contentType: MediaType(mimeType != null ? mimeType.split('/')[0] : '',
            mimeType != null ? mimeType.split('/')[1] : ''),
      ),
    );
  }

  final http.StreamedResponse response = await request.send();

  if (response.statusCode != 500) {
    return response.stream.toBytes();
  } else {
    request.headers['XA'] = prefs.getString('token') ?? '';
    final http.StreamedResponse response = await request.send();
    return response.stream.toBytes();
  }
}
