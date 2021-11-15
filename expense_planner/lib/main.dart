import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/new_transaction.dart';
import 'widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.teal[600],
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
      home: _MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class _MyHomePage extends StatefulWidget {
  @override
  __MyHomePageState createState() => __MyHomePageState();
}

class __MyHomePageState extends State<_MyHomePage> {
  final List<Transaction> transactions = [];
  bool _showChart = true;

  List<Transaction> get _recentTransactions {
    return transactions
        .where(
            (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime date) {
    final transaction = Transaction(
        title: txTitle,
        amount: txAmount,
        date: date,
        id: DateTime.now().toString());

    setState(() {
      transactions.add(transaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Home'),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                width: double.infinity,
                child: Column(
                  children: [
                    if (isLandscape)
                      Container(
                        height: (mediaQuery.size.height -
                                appBar.preferredSize.height -
                                mediaQuery.padding.top) *
                            0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Show Chart"),
                            Switch.adaptive(
                                activeColor: Theme.of(context).primaryColor,
                                value: _showChart,
                                onChanged: (value) {
                                  setState(() {
                                    _showChart = value;
                                  });
                                })
                          ],
                        ),
                      ),
                    if (isLandscape)
                      _showChart
                          ? _chartWidget(appBar, isLandscape, mediaQuery)
                          : _txtListWidget(appBar, isLandscape, mediaQuery)
                    else
                      Column(
                        children: [
                          _chartWidget(appBar, isLandscape, mediaQuery),
                          _txtListWidget(appBar, isLandscape, mediaQuery)
                        ],
                      )
                  ],
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _chartWidget(
      AppBar appBar, bool isLanscape, MediaQueryData mediaQuery) {
    double heightPercent = (isLanscape ? 0.7 : 0.25);
    return Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          heightPercent,
      child: Chart(_recentTransactions),
    );
  }

  Widget _txtListWidget(
      AppBar appBar, bool isLanscape, MediaQueryData mediaQuery) {
    double heightPercent = (isLanscape ? 0.7 : 0.75);
    return Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          heightPercent,
      child: TransactionList(
          transactions: transactions, deleteTransaction: _deleteTransaction),
    );
  }
}
