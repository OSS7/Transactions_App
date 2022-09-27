import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laravel_api/models/transaction.dart';
import 'package:laravel_api/providers/auth_provider.dart';
import 'package:laravel_api/providers/categories_provider.dart';
import 'package:laravel_api/widgets/delete_transaction_dialog.dart';
import 'package:laravel_api/widgets/edit_transaction_dialog.dart';
import 'package:provider/provider.dart';

class TransactionItem extends StatelessWidget {
  final LocalTransaction? transaction;
  final bool? isEven;

  const TransactionItem({Key? key, required this.transaction, this.isEven,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String formattedDate = DateFormat('yyyy/MM/dd, kk:mm')
        .format(transaction!.transactionDate ?? DateTime.now());

    return Center(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          // width: size.width * 0.95,
          height: size.height * 0.15,
          color:  isEven! ?  Colors.white :  Colors.black26,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      '${transaction!.id} ${transaction!.description ?? 'null'}', style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),),
                  Text('category: ${transaction!.categoryName ?? 'null'}'),
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(transaction!.amount.toString(), style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                      Text(formattedDate),
                    ],
                  ),
                  DeleteTransactionDialog(
                    transaction: transaction!,
                  ),
                  EditTransactionDialog(
                    transaction: transaction!,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
