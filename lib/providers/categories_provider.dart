import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:laravel_api/models/category.dart';

class CategoriesProvider with ChangeNotifier {
  List<LocalCategory> categories = [];
  String baseUrl = 'http://127.0.0.1:8000/api';

  changDropDownValue() {}
  getCategories(String token) async {
    http.Response response = await http.get(
      Uri.parse('$baseUrl/categories'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    debugPrint(response.body);
    categories = LocalCategory.decode(response.body.toString());
  }

  Future addCategory(String name, String token) async {
    String uri = '$baseUrl/categories';
    final respons = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body: jsonEncode({'name': name}));
    categories.add(LocalCategory(id: categories.length,name: name));
    notifyListeners();
  }

  Future editCategory(int id, String name, String token) async {
    String uri = '$baseUrl/categories/$id';
    await http.put(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      body: jsonEncode({'name': name}),
    );
    notifyListeners();
  }

  Future deleteCategory(int id, String token) async {
    String uri = '$baseUrl/categories/$id';
    await http.delete(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    categories.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
