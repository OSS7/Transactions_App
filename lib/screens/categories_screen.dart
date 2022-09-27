import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:laravel_api/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:laravel_api/providers/auth_provider.dart';
import 'package:laravel_api/providers/categories_provider.dart';
import 'package:laravel_api/widgets/add_category.dart';
import 'package:laravel_api/widgets/category_item.dart';
import 'package:laravel_api/widgets/delete_category_dialog.dart';
import 'package:laravel_api/widgets/edit_category_dialog.dart';
import 'package:laravel_api/widgets/screens_header.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final categoryProvider = Provider.of<CategoriesProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return const AddCategory();
              });
        },
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const ScreenHeader(text: 'Your Categories'),
          Expanded(
            child: FutureBuilder(
                future: categoryProvider.getCategories(authProvider.token),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: categoryProvider.categories.length,
                      itemBuilder: (context, index) {
                        return CategoryItem(
                          categroy: categoryProvider.categories[index],
                          isEven: index % 2 == 0 ? true : false,
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}
