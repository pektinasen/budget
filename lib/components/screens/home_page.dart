import 'package:flutter/material.dart';
import 'package:flutter_app/domain/transaction.dart';
import 'package:money2/money2.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final eur = Currency.create('EUR', 2,
      pattern: '#.###,##S', symbol: '€', invertSeparators: true);

  var transactionDialogVisible = false;
  var transactions = [
    Transaction(Uuid().v4obj(), "Rewe", Money.fromInt(1054, eur)),
    Transaction(Uuid().v4obj(), "Amazon - Phone", Money.fromInt(30000, eur)),
    Transaction(Uuid().v4obj(), "Mäcces", Money.fromInt(1500, eur)),
  ];

  String currentTransTitle = '';
  String currentTransValueText = '';

  void _toggleShowTransactionDialog() => setState(() {
        transactionDialogVisible = !transactionDialogVisible;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
                ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (ctx, idx) => ListTile(
                            title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(transactions[idx].title),
                            Text(transactions[idx].value.toString()),
                          ],
                        )))
              ] +
              _buildDialog(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleShowTransactionDialog,
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> _buildDialog() {
    return transactionDialogVisible
        ? [
            Dialog(
                child: Column(children: [
              TextField(
                onChanged: (text) {
                  setState(() {
                    currentTransTitle = text;
                  });
                },
                decoration: InputDecoration(labelText: 'title'),
              ),
              TextField(
                onChanged: (text) {
                  setState(() {
                    print("onChange Value");
                    currentTransValueText = text;
                  });
                },
                decoration: InputDecoration(labelText: 'value'),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                TextButton(
                    onPressed: () => _toggleShowTransactionDialog(),
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      setState(() {
                        transactions.add(Transaction(
                            Uuid().v4obj(),
                            currentTransTitle,
                            Money.fromString(currentTransValueText, eur,
                                pattern: '##,##')));
                        transactionDialogVisible = !transactionDialogVisible;
                      });
                    },
                    child: const Text('Add')),
              ]),
            ]))
          ]
        : [];
  }
}
