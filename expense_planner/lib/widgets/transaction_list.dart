import 'package:expense_planner/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  const TransactionList({this.transactions, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  "No transactions added yet",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container(
                  height: constraints.maxHeight * 0.5,
                  margin: EdgeInsets.only(top: 15),
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.contain,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, position) {
              return TransactionItem(
                transaction: transactions[position],
                deleteTransaction: deleteTransaction,
              );
            },
          );
  }
}
