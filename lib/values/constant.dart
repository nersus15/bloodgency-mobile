import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const BASEURL = "https://417c-182-1-68-128.ap.ngrok.io";
const Map<String, dynamic> Endpoint = {
  "login": "$BASEURL/auth/login",
  "logout": "$BASEURL/auth/logout",
  "register": "$BASEURL/auth/register",
  "reset_password": "$BASEURL/auth/reset",
  "email_Verify": "$BASEURL/auth/verify",
  "request_lists": "$BASEURL/blood/list",
  "create_request": "$BASEURL/blood/request",
  "donate": "$BASEURL/blood/donate"
};

const Map<String, List<BoxShadow>> boxShadow = {
  "light": [
    BoxShadow(
      color: Color.fromARGB(31, 143, 143, 143),
      blurRadius: 3,
      offset: Offset(0, 1),
    )
  ],
  'medium': [
    BoxShadow(
      color: Color.fromARGB(31, 143, 143, 143),
      blurRadius: 6,
      offset: Offset(2, 3),
    ),
    BoxShadow(
      color: Color.fromARGB(31, 143, 143, 143),
      blurRadius: 6,
      offset: Offset(2, 1),
    )
  ],
  'bold': [
    BoxShadow(
      color: Color.fromARGB(31, 24, 24, 24),
      blurRadius: 3,
      offset: Offset(0, 1),
    ),
    BoxShadow(
      color: Color.fromARGB(31, 24, 24, 24),
      blurRadius: 3,
      offset: Offset(1, 0),
    )
  ]
};

List<String> blood_category = [
  'A+',
  'A-',
  'B+',
  'B-',
  'AB+',
  'AB-',
  'O+',
  'O-'
];
