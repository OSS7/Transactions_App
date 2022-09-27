import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:laravel_api/models/transaction.dart';

class TransactionsProvider with ChangeNotifier {
  List<LocalTransaction> transactions = [];
  String baseUrl = 'http://127.0.0.1:8000/api';

  getTransactions(String token) async {
    http.Response response = await http.get(
      Uri.parse('$baseUrl/transactions'),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    transactions = LocalTransaction.decode(response.body.toString());
  }

  Future addTransaction(int categoryId, String amount, String description,
      String transDate, String token, BuildContext context) async {
    String uri = '$baseUrl/transactions';
    final respons = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body: jsonEncode({
          'category_id': categoryId,
          'amount': int.parse(amount),
          'description': description,
          'transaction_date': transDate,
        }));
    if (respons.statusCode == 201) {
      Navigator.of(context).pop();
    }
    notifyListeners();
  }

  Future editTransaction(int id, String amount, String description,
      int categoryId, String transactionDate, String token) async {
    String uri = '$baseUrl/transactions/$id';
    await http.put(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      body: jsonEncode({
        'description': description,
        'category_id': categoryId,
        'amount': amount,
        'transaction_date': transactionDate,
      }),
    );
    notifyListeners();
  }

  Future deleteTransaction(int id, String token) async {
    String uri = '$baseUrl/transactions/$id';
    await http.delete(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    notifyListeners();
  }
}
