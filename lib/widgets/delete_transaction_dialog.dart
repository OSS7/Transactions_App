import 'package:flutter/material.dart';
import 'package:laravel_api/models/category.dart';
import 'package:laravel_api/models/transaction.dart';
import 'package:laravel_api/providers/auth_provider.dart';
import 'package:laravel_api/providers/categories_provider.dart';
import 'package:laravel_api/providers/transactions_provider.dart';
import 'package:provider/provider.dart';

class DeleteTransactionDialog extends StatefulWidget {
  final LocalTransaction? transaction;

  const DeleteTransactionDialog({Key? key, this.transaction}) : super(key: key);

  @override
  State<DeleteTransactionDialog> createState() => _DeleteTransactionDialogState();
}

class _DeleteTransactionDialogState extends State<DeleteTransactionDialog> {

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final transProvider = Provider.of<TransactionsProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return  IconButton(
      icon: Icon(Icons.delete,color: Colors.red.shade700,),
      onPressed: () {

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                    'you sure you want to delete this category'),
                actions: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          transProvider.deleteTransaction(
                              widget.transaction!
                                  .id ??
                                  0,
                              authProvider.token
                          );
                        });
                        Navigator.pop(context);
                      },
                      child: Text('yes')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('no'))
                ],
              );
            });
      },
    );
  }
}
