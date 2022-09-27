import 'package:flutter/material.dart';
import 'package:laravel_api/providers/auth_provider.dart';
import 'package:laravel_api/providers/categories_provider.dart';
import 'package:laravel_api/providers/transactions_provider.dart';
import 'package:provider/provider.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {

  final TextEditingController _name = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final categoryProvider = Provider.of<CategoriesProvider>(context);
    final transactionProvider = Provider.of<TransactionsProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Container(
      padding: const EdgeInsets.all(50),
      height: size.height * 0.3,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextField(
            controller: _name,
            decoration: const InputDecoration(
              hintText: 'Name',
              focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.purple, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide:
                BorderSide(color: Colors.purple, width: 1),
              ),
            ),
          ),
          MaterialButton(
            color: Colors.purple,
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              categoryProvider.addCategory(_name.text.toString(),authProvider.token);

              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
