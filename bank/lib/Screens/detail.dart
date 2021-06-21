import 'package:app/Screens/sendTo.dart';
import 'package:app/data/customer.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Details extends StatefulWidget {
  Details({this.customer, this.index});

  final Customer customer;
  final int index;

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final valueStyle = TextStyle(
    fontSize: 20.0,
    color: Colors.amber,
  );
  final titleStyle = TextStyle(
    fontSize: 20.0,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.white.withOpacity(0.0),
          elevation: 0.0,
          leading: MediaQuery.of(context).size.width < 600
              ? IconButton(
                  icon:
                      Icon(Icons.arrow_back_rounded, color: Color(0xFF333333)),
                  onPressed: () => Navigator.pop(context),
                )
              : null),
      body: SingleChildScrollView(
        child: Center(
          child: getDetails(),
        ),
      ),
    );
  }

  WatchBoxBuilder getDetails() {
    final box = Hive.box<Customer>('customers');
    return WatchBoxBuilder(
      box: box,
      builder: (context, box) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 40.0),
            CircleAvatar(
                backgroundColor: Color(0xFF333333),
                minRadius: 30.0,
                maxRadius: 30.0,
                child: widget.customer.gender == "Male"
                    ? Icon(
                        Icons.person,
                        color: Colors.amber,
                      )
                    : Icon(
                        Icons.female,
                        color: Colors.amber,
                      )),
            SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Name: ", style: titleStyle),
                Text(widget.customer.name, style: valueStyle),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Email id: ", style: titleStyle),
                Text(widget.customer.email, style: valueStyle),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Account Type: ", style: titleStyle),
                Text(widget.customer.accountType + "Account",
                    style: valueStyle),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Gender: ", style: titleStyle),
                Text(widget.customer.gender, style: valueStyle),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Balance: ", style: titleStyle),
                Text(box.getAt(widget.index).balance.toString(),
                    style: valueStyle),
              ],
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Transfer Money"),
              ),
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Receiver(index: widget.index)));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
  //
  // @override
  // void dispose() {
  //   Hive.close();
  //   super.dispose();
  // }
}
