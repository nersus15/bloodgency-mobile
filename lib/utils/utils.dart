import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

typedef VoidCallbackArg = void Function(http.Response response);

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

  get({
    required String url,
    required VoidCallbackArg onSuccess,
    Map<String, String>? headers,
    VoidCallbackArg? onError,
  }) async {
    final response =
        await http.get(Uri.parse(url), headers: headers).catchError(
      (err) {
        print("Utils.Internet.fetch Error");

        onError!(err);
      },
      test: (error) {
        print("Utils.Internet.fetch Error");
        print(error);
        return error is int && error >= 400;
      },
    );

    if (response.statusCode == 200) {
      print("Utils.Internet.fetch Success");
      onSuccess(response);
    } else {
      print("Utils.Internet.fetch Error");
      onError!(response);
    }
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
        }
        print("Utils.Internet.fetch Start Request to $url$suffix");
        await get(
            url: "$url$suffix",
            onSuccess: onSuccess,
            onError: onError,
            headers: headers);
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
}
