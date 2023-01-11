import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:palapa1/utils/change_prefs.dart';
import 'package:palapa1/utils/config.dart';
import 'package:palapa1/widgets/toast_custom.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> login({required String username, required String pass}) async {
  final http.Client client = http.Client();
  try {
    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse('${Config.domain}api/login'));
    request.fields.addAll(<String, String>{
      'username': username,
      'password': pass,
    });
    http.StreamedResponse response = await request.send();
    return jsonDecode(await response.stream.bytesToString());
  } on TimeoutException {
    showToast('Request Timeout');
    return <String, dynamic>{'status': -1, 'message': 'Request Timeout'};
  } on SocketException {
    showToast('No Connection Detected');
    return <String, dynamic>{'status': -1, 'message': 'No Connection Detected'};
  }
}

Future<dynamic> fetchData(
  String url, {
  FetchDataMethod method = FetchDataMethod.get,
  TokenLabel tokenLabel = TokenLabel.tokenId,
  int timeoutInSecond = 30,
  Map<String, String> extraHeader = const <String, String>{},
  String rtoMessage = 'Request Timeout',
  String noConnectionMessage = 'No Connection Detected',
  bool showToastWhenRto = true,
  bool useBaseUrl = true,
  bool showToastWhenNoConnection = true,
  Map<String, dynamic> params = const <String, dynamic>{},
  List<String>? paramsDelete = const <String>[],
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final http.Client client = http.Client();
  try {
    //default header
    final Map<String, String> _headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      tokenLabel == TokenLabel.xa ? 'XA' : 'token-id':
          prefs.getString('token').toString()
    };

    //adding extra header if exist
    _headers.addAll(extraHeader);

    //functions to request to endpoint
    Future<http.Response> _getResponse(Map<String, String>? _h) async {
      if (method == FetchDataMethod.put) {
        return client
            .put(
              Uri.parse(useBaseUrl ? '${Config.domain}$url' : '$url'),
              headers: _h ?? _headers,
              body: jsonEncode(params),
            )
            .timeout(Duration(seconds: timeoutInSecond));
      } else if (method == FetchDataMethod.post) {
        return client
            .post(
              Uri.parse(useBaseUrl ? '${Config.domain}$url' : '$url'),
              headers: _h ?? _headers,
              body: jsonEncode(params),
            )
            .timeout(Duration(seconds: timeoutInSecond));
      } else if (method == FetchDataMethod.delete) {
        return client
            .delete(
              Uri.parse(useBaseUrl ? '${Config.domain}$url' : '$url'),
              headers: _h ?? _headers,
              body: jsonEncode(paramsDelete),
            )
            .timeout(Duration(seconds: timeoutInSecond));
      } else {
        return client
            .get(
              Uri.parse(useBaseUrl ? '${Config.domain}$url' : '$url'),
              headers: _h ?? _headers,
            )
            .timeout(Duration(seconds: timeoutInSecond));
      }
    }

    // //do request to endpoint
    final http.Response response = await _getResponse(null);
    if (response.statusCode != 500) {
      //Close request after endpoint send callback
      client.close();

      return jsonDecode(response.body);
    } else {
      final http.Response response = await _getResponse(<String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
        tokenLabel == TokenLabel.xa ? 'XA' : 'token-id':
            prefs.getString('token').toString()
      });

      //Close request after endpoint send callback
      client.close();

      return jsonDecode(response.body);
    }
  } on TimeoutException {
    //Triggered when timeout
    if (showToastWhenRto) showToast(rtoMessage);
    return <String, dynamic>{'status': 0, 'message': rtoMessage};
  } on SocketException {
    //Triggered hen no internet connection
    if (showToastWhenNoConnection) showToast(noConnectionMessage);
    return <String, dynamic>{'status': 0, 'message': noConnectionMessage};
  }
}

Future<dynamic> uploadImage(List<File> files) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final http.MultipartRequest request = http.MultipartRequest(
      'POST', Uri.parse('${Config.domain}dmsv2/uploadfile'));

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
    final String respStr = await response.stream.bytesToString();
    return jsonDecode(respStr);
  } else {
    getPrefsProfile().then((Map<String, dynamic> value) {
      login(
              username: value['user_email'] as String,
              pass: value['user_password'] as String)
          .then((dynamic cb) async {
        if (cb.containsKey('token') == true) {
          await changePrefsLogin(<String, String>{
            'password': value['user_password'] as String,
            'email': cb['email'] as String,
            'token': cb['token'] as String
          });
        }
        return;
      });
    });

    request.headers['XA'] = prefs.getString('token') ?? '';
    final http.StreamedResponse response = await request.send();
    final String respStr = await response.stream.bytesToString();
    return jsonDecode(respStr);
  }
}
