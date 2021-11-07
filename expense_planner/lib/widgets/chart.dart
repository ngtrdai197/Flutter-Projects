import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart-bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var tx in recentTransactions) {
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          totalSum += tx.amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0,
        (previousValue, currentGtx) => previousValue += currentGtx['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues
                .map((gtx) => Flexible(
                      fit: FlexFit.tight,
                      child: ChartBar(
                          label: gtx['day'],
                          spendingAmount: gtx['amount'],
                          spendingPercentOfTotal: maxSpending == 0
                              ? 0.0
                              : ((gtx['amount'] as double) / maxSpending)),
                    ))
                .toList()),
      ),
    );
  }
}
