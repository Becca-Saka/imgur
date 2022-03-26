import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:imgur/app/config.dart';

class MyWebApp extends StatefulWidget {
  @override
  _MyWebAppState createState() => new _MyWebAppState();
}

class _MyWebAppState extends State<MyWebApp> {
  InAppWebViewController? _webViewController;
  String url = "";
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('InAppWebView Example'),
        ),
        body: Container(
            child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
                "CURRENT URL\n${(url.length > 50) ? url.substring(0, 50) + "..." : url}"),
          ),
          Container(
              padding: EdgeInsets.all(10.0),
              child: progress < 1.0
                  ? LinearProgressIndicator(value: progress)
                  : Container()),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              child: InAppWebView(
                
                initialUrlRequest: URLRequest(
                    url: Uri.parse(
                        "https://api.imgur.com/oauth2/authorize?client_id=$clientID&response_type=token")),
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      
                        userAgent:
                            "Mozilla/5.0 (Linux; Android 10; Redmi Note 8 Pro) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.88 Mobile Safari/537.36"
                        // debuggingEnabled: true,

                        )),
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                },
                onLoadStart: (InAppWebViewController controller, Uri? url) {
                  log("onLoadStart: $url");
                  setState(() {
                    this.url = url.toString();
                  });
                },
                onLoadStop:
                    (InAppWebViewController controller, Uri? url) async {
                  setState(() {
                    this.url = url.toString();
                  });
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ),
          ),
          ])),
      ),
    );
  }
}
