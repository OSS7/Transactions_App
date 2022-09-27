

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:laravel_api/models/category.dart';
import 'package:laravel_api/providers/auth_provider.dart';
import 'package:laravel_api/providers/categories_provider.dart';
import 'package:provider/provider.dart';


class EditCategoryDialog extends StatefulWidget {
  final LocalCategory? category;
  const EditCategoryDialog({Key? key, this.category}) : super(key: key);

  @override
  State<EditCategoryDialog> createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  final TextEditingController? nameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final categoryProvider = Provider.of<CategoriesProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return  IconButton(
      icon: Icon(Icons.edit,color: Colors.purple,),
      onPressed: () {
        setState(() {
         nameController!.text =
              widget.category!.name.toString();
        });
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(50),
                height: size.height * 0.3,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight:
                        Radius.circular(20),
                        topLeft:
                        Radius.circular(20))),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration:
                      const InputDecoration(
                        hintText: 'Name',
                        focusedBorder:
                        OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.purple,
                              width: 1),
                        ),
                        enabledBorder:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(
                                  10)),
                          borderSide: BorderSide(
                              color: Colors.purple,
                              width: 1),
                        ),
                      ),
                    ),
                    MaterialButton(
                      color: Colors.purple,
                      child: Text(
                        'Edit',
                        style: TextStyle(
                            color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          categoryProvider.editCategory(
                              widget.category!.id??
                                  0,
                              nameController!.text.toString(),
                          authProvider.token
                          );
                          Navigator.of(context)
                              .pop();
                        });
                      },
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}
