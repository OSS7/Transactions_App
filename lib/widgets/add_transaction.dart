import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laravel_api/providers/auth_provider.dart';
import 'package:laravel_api/providers/categories_provider.dart';
import 'package:laravel_api/providers/transactions_provider.dart';
import 'package:laravel_api/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {

  final TextEditingController _description = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _date = TextEditingController();
  // final TextEditingController _name = TextEditingController();
  int dropDownValue = 0;
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final categoryProvider = Provider.of<CategoriesProvider>(context);
    final transactionProvider = Provider.of<TransactionsProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Container(
      padding: EdgeInsets.all(25),
      height: size.height * 0.5,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomTextField(
            controller: _description,
            hint: 'Description',
          ),
          CustomTextField(
            controller: _amount,
            hint: 'Amount',
          ),
          DropdownButtonFormField(
            // value: dropDownValue,

            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: categoryProvider.categories.map((items) {
              return DropdownMenuItem(
                value: items.id,
                child: Text(items.name.toString()),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (newValue) {
              setState(() {
                dropDownValue = int.parse(newValue.toString());
              });
            },
          ),
          TextField(
            controller: _date,
            decoration: const InputDecoration(
              hintText: 'Transaction Date',
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
            onTap: () async {
              // _date.text = initialDatePicker;

              final DateTime? picker = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2025));
              if (picker != null) {
                setState(() {
                  _date.text =
                      DateFormat('yyyy/MM/dd').format(picker);
                });
              }
            },
          ),
          // CustomTextField(controller: _date,hint: 'Date',),
          MaterialButton(
              color: Colors.purple,
              child: Text('Add Transaction',style: TextStyle(
                color: Colors.white
              ),),
              onPressed: () async {
                // debugPrint('${dropDownValue.toInt()} ${_amount.text} ${_description.text}, ${auth.token}');
                transactionProvider.addTransaction(
                    dropDownValue,
                    _amount.text,
                    _description.text,
                    _date.text,
                    authProvider.token,
                    context);
              })
        ],
      ),
    );
  }
}
