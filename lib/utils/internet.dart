import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Internet {
  bool isWaiting = false;

  noInternet(BuildContext context,
      {String title = "No Internet Access"}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text("You Must Connected to Internet"),
          actions: [
            TextButton(
              onPressed: () {
                isWaiting = true;
                Navigator.pop(context);
              },
              child: Text(
                'Wait',
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Close',
                style: TextStyle(color: Color.fromARGB(255, 142, 38, 30)),
              ),
            ),
          ],
        );
      },
    );
  }

  isConnected(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      } else {
        print(result);
        await noInternet(context);
      }
    } on SocketException catch (_) {
      await noInternet(context);
    }
  }
}
