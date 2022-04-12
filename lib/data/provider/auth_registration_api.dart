import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_flexicar_registration_poc/constant/strings.dart';
import 'package:http/http.dart' as http;

// import 'package:http/http.dart' as http;

class AuthRegistrarionApi {
  Future<http.Response> submitRegistration(
      int type,
      String lastname,
      String firstname,
      String email,
      String password,
      String confirmPassword,
      String contact,
      String country,
      int isMailSubscriber) async {
    String jsonToSend = jsonEncode(<String, dynamic>{
      'type': type,
      'lastname': lastname,
      'firstname': firstname,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
      'contact': contact,
      'country': country,
      'is_mail_subscriber': isMailSubscriber,
    });
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };

    final response = await http.post(
        Uri.parse('${Strings.baseApiUrl}/auth/register'),
        headers: headers,
        body: jsonToSend);

    debugPrint('## ${response.body}');

    return response;
  }
}
