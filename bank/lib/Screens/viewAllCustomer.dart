import 'package:app/data/customer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'detail.dart';
import 'transactionPage.dart';

class AllCustomer extends StatefulWidget {
  @override
  State<AllCustomer> createState() => _AllCustomerState();
}

class _AllCustomerState extends State<AllCustomer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Hive.openBox<Customer>('customer'),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // print(snapshot.data);
            if (snapshot.hasError) return Text("Error");
            return Scaffold(
              appBar: AppBar(
                title: Text("All Users"),
                actions: <Widget>[
                  TextButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => TransactionPage())),
                      child: Icon(
                        Icons.attach_money,
                        color: Colors.white,
                      ))
                ],
              ),
              body: Column(
                // scrollDirection: Axis.vertical,
                // shrinkWrap: false,
                children: <Widget>[
                  Expanded(
                    child: getList(),
                  )
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  WatchBoxBuilder getList() {
    final box = Hive.box<Customer>('customers');
    return WatchBoxBuilder(
        box: box,
        builder: (context, box) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: box.length,
            itemBuilder: (BuildContext context, int index) {
              final customer = box.get(index) as Customer;
              return Card(
                child: ListTile(
                  title: Text(customer.name),
                  subtitle: Text(customer.balance.toString()),
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Details(
                          customer: customer,
                          index: index,
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  },
                ),
              );
            },
          );
        });
  }
}
