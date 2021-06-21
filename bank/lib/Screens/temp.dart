import 'package:app/data/customer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'global.dart';
import 'detail.dart';
import 'transactionPage.dart';

class AllCustomer2 extends StatefulWidget {
  @override
  State<AllCustomer2> createState() => _AllCustomerState2();
}

class _AllCustomerState2 extends State<AllCustomer2> {
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
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TransactionPage()));
                        // Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.attach_money,
                        color: Colors.white,
                      ))
                ],
              ),
              body: LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return WideLayout();
                } else {
                  return NarrowLayout();
                }
              }),
            );
          } else {
            return Scaffold();
          }
        });
  }
}

class WideLayout extends StatefulWidget {
  @override
  State<WideLayout> createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  // static Customer cust;
  // int index;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            // scrollDirection: Axis.vertical,
            // shrinkWrap: false,
            children: <Widget>[
              Expanded(
                child: getList(
                  onTapFunction: () => setState(() {
                    gcust = gcustomer;
                  }),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: gcust == null
              ? Center(child: Text("Select customer to see Details"))
              : Details(customer: gcust, index: gIndex),
        )
      ],
    );
  }
}

class NarrowLayout extends StatefulWidget {
  @override
  _NarrowLayoutState createState() => _NarrowLayoutState();
}

class _NarrowLayoutState extends State<NarrowLayout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // scrollDirection: Axis.vertical,
      // shrinkWrap: false,
      children: <Widget>[
        Expanded(
          child: getList(onTapFunction: () async {
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Details(
                      customer: gcustomer,
                      index: gIndex,
                    )));
            // Navigator.pop(context);
          }),
        )
      ],
    );
  }
}

class getList extends StatelessWidget {
  const getList({Key key, this.onTapFunction}) : super(key: key);
  final void Function() onTapFunction;

  @override
  Widget build(BuildContext context) {
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
                  onTap: () {
                    gcustomer = customer;
                    gIndex = index;
                    onTapFunction();
                  },
                ),
              );
            },
          );
        });
  }
}
//
// WatchBoxBuilder getList() {
//
// }
