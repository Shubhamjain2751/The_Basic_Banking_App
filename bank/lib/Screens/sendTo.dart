import 'package:app/data/customer.dart';
import 'package:app/data/transaction.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Receiver extends StatefulWidget {
  Receiver({Key key, this.index}) : super(key: key);
  final int index;

  @override
  _ReceiverState createState() => _ReceiverState();
}

class _ReceiverState extends State<Receiver> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox<Customer>('customers'),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text("error");
          }
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text("Send To"),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: getList(),
                )
              ],
            ),
          );
        } else {
          return Scaffold();
        }
      },
    );
  }

  ListView getList() {
    final tBox = Hive.box<Transaction>('transaction');
    final box = Hive.box<Customer>('customers');
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: box.length,
      itemBuilder: (BuildContext context, int index) {
        final customer = box.get(index) as Customer;
        final TextEditingController _controller = TextEditingController();
        return Card(
          child: ListTile(
              title: Text(customer.name),
              onTap: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _controller,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 2.0)),
                                  labelText: "Amount",
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (int.parse(_controller.text) >
                                            box.getAt(widget.index).balance ||
                                        int.parse(_controller.text) <= 0) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              int.parse(_controller.text) <= 0
                                                  ? "Invalid Amount"
                                                  : 'Insufficient Balance'),
                                          duration: const Duration(
                                              milliseconds: 1500),
                                          width: 280.0,
                                          // Width of the SnackBar.
                                          padding: const EdgeInsets.symmetric(
                                            horizontal:
                                                8.0, // Inner padding for SnackBar content.
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      );
                                    } else {
                                      Customer temp = Customer()
                                        ..name = customer.name
                                        ..email = customer.email
                                        ..accountType = customer.accountType
                                        ..balance = customer.balance +
                                            int.parse(_controller.text)
                                        ..gender = customer.gender;

                                      box.putAt(index, temp);
                                      temp = box.getAt(widget.index);
                                      temp.balance -=
                                          int.parse(_controller.text);
                                      box.putAt(widget.index, temp);

                                      Transaction transaction2 = Transaction()
                                        ..receiver = customer.name
                                        ..sender = box.getAt(widget.index).name
                                        ..time = DateTime.now()
                                        ..transaction_amount = _controller.text;
                                      tBox.add(transaction2);

                                      Navigator.pop(context, 'Transfer');
                                      Navigator.pop(
                                          context); //sendto page poped
                                      // Navigator.pop(
                                      //     context); //detailPage page poped

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('Transfer Successful'),
                                            ],
                                          ),
                                          duration: const Duration(
                                              milliseconds: 1500),
                                          width: 280.0,
                                          // Width of the SnackBar.
                                          padding: const EdgeInsets.symmetric(
                                            horizontal:
                                                8.0, // Inner padding for SnackBar content.
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      );
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Transfer'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'cancel'),
                                  child: const Text('Cancel'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      title: Text('Transferring to ${customer.name}'),
                    ),
                  )),
        );
      },
    );
  }
}
