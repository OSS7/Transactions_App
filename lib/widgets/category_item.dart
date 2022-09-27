import 'package:flutter/material.dart';
import 'package:laravel_api/models/category.dart';
import 'package:laravel_api/providers/auth_provider.dart';
import 'package:laravel_api/providers/categories_provider.dart';
import 'package:laravel_api/widgets/delete_category_dialog.dart';
import 'package:laravel_api/widgets/edit_category_dialog.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  final LocalCategory? categroy;
  final bool? isEven;
  const CategoryItem({Key? key, this.categroy, this.isEven}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        // margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        // width: size.width * 0.95,
        height: size.height * 0.15,
        // color: Colors.black26,
        color: isEven!
            ? Colors.white54
            : Colors.black26,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(categroy!.name.toString(),
                  style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                // Text(categroy!.id.toString()),
              ],
            ),
            Row(
              children: [
                DeleteCategoryDialog(category: categroy!,),
                EditCategoryDialog(
                  category: categroy!,
                  // nameController: _name,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
