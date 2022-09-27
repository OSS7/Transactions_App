import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool isAuthenticated = false;
  String token = '';

  setToken() async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('token', token);
  }

  removeToken() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove('token');
  }

  getToken() async {
    final pref = await SharedPreferences.getInstance();
    token = pref.getString('token') ?? '';
    if (token.isNotEmpty) {
      isAuthenticated = true;
    }
  }

  Future register(String name, String email, String password) async {
    String uri = 'http://127.0.0.1:8000/api/auth/register';
    final response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'device_name': 'android'
        }));
    token = response.body;
    notifyListeners();
  }

  Future login(String email, String password, BuildContext context) async {
    String uri = 'http://127.0.0.1:8000/api/auth/login';
    final response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }));
    if (response.statusCode == 200) {
      Navigator.of(context).pushNamed('/HomeScreen');
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(response.body),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok')),
              ],
            );
          });
    }
    print(response.body);
    token = response.body;
    setToken();
    notifyListeners();
  }

  Future logout(BuildContext context) async {
    String uri = 'http://127.0.0.1:8000/api/auth/logout';
    final response = await http.post(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 204) {
      Navigator.of(context).pushNamed('/LoginScreen');
      removeToken();
    }
    print(response.body);
    token = response.body;
    notifyListeners();
  }
}
