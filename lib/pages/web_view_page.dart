import 'dart:io';

import 'package:flutter/material.dart';
import 'package:palapa1/utils/config.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  const WebViewPage({super.key, required this.url});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final _key = UniqueKey();
  late WebViewController _controller;
  late bool _isLoadingPage = false;

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    print('isi dari url ${widget.url}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        backgroundColor: Config.primaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: Config.whiteColor,
          ),
        ),
        title: Text(
          'News',
          style: Config.whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: Config.bold,
          ),
        ),
      ),
      body:  WebView(
              initialUrl: '${widget.url}',
              key: _key,
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (value) {
                setState(() {

                  _isLoadingPage = true;
                  print('isi dari is loading true $_isLoadingPage');

                });
              },
              onPageFinished: (value) {
                setState(() {
                  _isLoadingPage = false;
                  print('isi dari is loading $_isLoadingPage');

                });
              },
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
              },
            ),
    );
  }
}
