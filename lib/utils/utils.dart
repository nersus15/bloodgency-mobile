import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:localstore/localstore.dart';

typedef VoidCallbackArg = void Function(http.Response? response);

class Internet {
  bool isWaiting = false;
  bool isConnected = true;

  void Function;
  noInternet(BuildContext context,
      {String title = "No Internet Access"}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: const Text("You Must Connected to Internet"),
          actions: [
            TextButton(
              onPressed: () {
                isWaiting = true;
                Navigator.pop(context);
              },
              child: const Text(
                'Wait',
              ),
            ),
            TextButton(
              onPressed: () {
                isWaiting = false;
                Navigator.pop(context);
              },
              child: const Text(
                'Close',
                style: TextStyle(color: Color.fromARGB(255, 142, 38, 30)),
              ),
            ),
          ],
        );
      },
    );
  }

  void get({
    required String url,
    required VoidCallbackArg onSuccess,
    Map<String, String>? headers,
    VoidCallbackArg? onError,
  }) {
    http.get(Uri.parse(url), headers: headers).then((response) {
      if (response.statusCode == 200) {
        print("Utils.Internet.fetch Success");
        onSuccess(response);
      } else {
        print("Utils.Internet.fetch Error [response code != 200]");
        onError!(response);
      }
    }, onError: (err, stack) {
      print("Utils.Internet.fetch Error [request failed]");
      print(err);
      onError!(null);
    });
  }

  void post({
    required String url,
    required VoidCallbackArg onSuccess,
    required Object? body,
    Map<String, String>? headers,
    VoidCallbackArg? onError,
  }) {
    http
        .post(
      Uri.parse(url),
      headers: headers,
      body: body,
    )
        .then((response) {
      if (response.statusCode == 200) {
        print("Utils.Internet.fetch Success");
        onSuccess(response);
      } else {
        print("Utils.Internet.fetch Error [response code != 200]");
        onError!(response);
      }
    }, onError: (err, stack) {
      print("Utils.Internet.fetch Error [request failed]");
      print(err);
      onError!(null);
    });
  }

  // fetch data and send callback funtion
  fetch({
    required BuildContext context,
    required String url,
    required VoidCallbackArg onSuccess,
    String method = 'GET',
    Map<String, String>? params,
    VoidCallbackArg? onError,
    VoidCallback? onNoInternet,
    Map<String, String>? headers,
    Object? body,
  }) async {
    try {
      print("Utils.Internet.fetch Checking Internet");
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
        String suffix = '';
        if (method == 'GET') {
          if (params != null) {
            suffix += "?";
            for (var key in params.keys) {
              suffix += "$key=${params[key]}";
            }
          }
        } else if (method == 'POST') {
          if (headers != null) {
            headers!["Content-Type"] =
                "application/x-www-form-urlencoded; charset=UTF-8";
          } else {
            headers = {"Content-Type": "application/x-www-form-urlencoded"};
          }
        }
        print("Utils.Internet.fetch Start Request to $url$suffix");
        print("Headers ==============>");
        print(headers);
        if (method == 'GET') {
          get(
              url: "$url$suffix",
              onSuccess: onSuccess,
              onError: onError,
              headers: headers);
        } else if (method == 'POST') {
          post(
              url: "$url$suffix",
              onSuccess: onSuccess,
              body: body,
              onError: onError,
              headers: headers);
        }
      } else {
        isConnected = false;
        print("Utils.Internet.fetch No Internet");

        await noInternet(context);
      }
    } on SocketException catch (_) {
      isConnected = false;
      print("Utils.Internet.fetch No Internet");
      await noInternet(context);
    }

    if (isWaiting) {
      fetch(
          context: context,
          url: url,
          method: method,
          params: params,
          onSuccess: onSuccess,
          onError: onError,
          headers: headers,
          onNoInternet: onNoInternet);
    } else {
      if (!isConnected) onNoInternet!();
    }
  }
}

class Utils {
  static Internet internet = Internet();
  static bool isValidEmail(String text) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(text);
  }

  static String waktu({DateTime? time, String format = "dd-MM-yyyy hh:mm"}) {
    if (time == null) {
      time = DateTime.now();
    }
    String f = DateFormat(
      format,
    ).format(time);
    return f.toString();
  }

  static Future<Map<String, dynamic>> isLogin(BuildContext context) async {
    final localStorage = Localstore.instance;
    bool isExpired = false;
    String? tkn;

    Map<String, dynamic>? token =
        await localStorage.collection('auth').doc('token').get();
    if (token != null) {
      isExpired = JwtDecoder.isExpired(token['token']);
      tkn = token['token'];
    }
    if (isExpired) {
      tkn = null;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Session Anda sudah kadaluarsa, silahkan login ulang"),
      ));
    }
    return {"isLogin": token != null && !isExpired, "token": tkn};
  }
}
