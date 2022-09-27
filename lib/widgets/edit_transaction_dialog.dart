

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laravel_api/models/category.dart';
import 'package:laravel_api/models/transaction.dart';
import 'package:laravel_api/providers/auth_provider.dart';
import 'package:laravel_api/providers/categories_provider.dart';
import 'package:laravel_api/providers/transactions_provider.dart';
import 'package:provider/provider.dart';


class EditTransactionDialog extends StatefulWidget {
  final LocalTransaction? transaction;
  const EditTransactionDialog({Key? key, this.transaction}) : super(key: key);

  @override
  State<EditTransactionDialog> createState() => _EditTransactionDialogState();
}

class _EditTransactionDialogState extends State<EditTransactionDialog> {
  final TextEditingController? desController = TextEditingController();
  final TextEditingController? amountController = TextEditingController();
  final TextEditingController? dateController = TextEditingController();
  int categoryId = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final trans = Provider.of<TransactionsProvider>(context);
    final cated = Provider.of<CategoriesProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return  IconButton(
      icon: Icon(Icons.edit,color: Colors.purple,),

      onPressed: () {
        setState(() {
          desController!.text = widget.transaction!.description.toString();
          amountController!.text = widget.transaction!.amount.toString();
          dateController!.text = DateFormat('yyyy/MM/dd').format(widget.transaction!.transactionDate??DateTime.now());
          categoryId = widget.transaction!.categoryId??0;
        });
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(50),
                height: size.height * 0.5,
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
                      controller: desController,
                      decoration:
                      const InputDecoration(
                        hintText: 'Description',
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
                    TextField(
                      controller: amountController,
                      decoration:
                      const InputDecoration(
                        hintText: 'Amount',
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
                    DropdownButtonFormField(
                      // value: dropDownValue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: cated.categories.map((items) {
                        return DropdownMenuItem(
                          value: items.id,
                          child: Text(items.name.toString()),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (newValue) {
                        setState(() {
                          categoryId = int.parse(newValue.toString());
                          // = newValue.toString();
                        });
                        print(newValue.toString());
                      },
                    ),
                    TextField(
                      onTap: () async{
                        final DateTime? picker = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2025));
                        if (picker != null) {
                          setState(() {
                            dateController!.text =
                                DateFormat('yyyy/MM/dd').format(picker);
                          });
                        }
                      },
                      controller: dateController,
                      decoration:
                      const InputDecoration(
                        hintText: 'Date',
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
                          trans.editTransaction(
                              widget.transaction!.id??0,
                              amountController?.text??'',
                              desController?.text??'',
                              categoryId,
                              dateController!.text,
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
