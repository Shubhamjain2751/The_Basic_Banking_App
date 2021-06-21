import 'package:app/data/transaction.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Hive.openBox<Transaction>('transaction'),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Error");
            }
            return Scaffold(
                appBar: AppBar(title: Text("Transactions")),
                body: Column(
                  children: <Widget>[
                    Expanded(
                      child: getTransaction(),
                    )
                  ],
                ));
          } else {
            return Scaffold();
          }
        });
  }

  WatchBoxBuilder getTransaction() {
    final tbox = Hive.box<Transaction>('transaction');
    return WatchBoxBuilder(
        box: tbox,
        builder: (context, box) {
          final transList = tbox.values.toList().reversed.toList();
          // transList.reversed.toList();
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: box.length,
            // reverse: true,
            itemBuilder: (BuildContext context, int index) {
              final trans = tbox.getAt(index);
              return Card(
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Text(transList[index]
                          .sender
                          .substring(0, transList[index].sender.indexOf(" "))),
                      SizedBox(width: 10.0),
                      // trans.sender.substring(0, trans.sender.indexOf(' '))),
                      Icon(
                        Icons.arrow_forward_outlined,
                        size: 20.0,
                      ),
                      SizedBox(width: 10.0),
                      Text(transList[index].receiver.substring(
                          0, transList[index].receiver.indexOf(" "))), //)
                    ],
                  ),
                  subtitle: Text(transList[index].time.day.toString() +
                      "/" +
                      transList[index].time.month.toString() +
                      "/" +
                      transList[index].time.year.toString() +
                      "\n" +
                      transList[index].time.hour.toString() +
                      ":" +
                      transList[index].time.minute.toString()),
                  trailing: Text(
                    "\$ " +
                        int.parse(transList[index].transaction_amount)
                            .toString(),
                    style: TextStyle(color: Color(0xFF7cbb00), fontSize: 18.0),
                  ),
                ),
              );
            },
          );
        });
  }
}
