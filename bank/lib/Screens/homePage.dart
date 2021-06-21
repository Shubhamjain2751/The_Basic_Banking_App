import 'package:app/Screens/temp.dart';
import 'package:app/data/customer.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'viewAllCustomer.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    setFlag();
  }

  Future<bool> isFirstStart() async {
    final prefs = await SharedPreferences.getInstance();
    final check = prefs.getBool('start');
    if (check == null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> setFlag() async {
    final prefs = await SharedPreferences.getInstance();
    final start2 = await isFirstStart();
    if (start2 == true) {
      await prefs.setBool('start', false);
      await Hive.openBox<Customer>('customers');
      final box = Hive.box<Customer>('customers');

      final customer1 = Customer()
        ..name = "Celine Blew"
        ..email = "cblew0@mapquest.com"
        ..accountType = "Savings"
        ..balance = 2316
        ..gender = "Male";
      await box.add(customer1);
      final customer2 = Customer()
        ..name = "Carin Robard"
        ..email = "crobard@mapquest.com"
        ..accountType = "Current"
        ..balance = 2345
        ..gender = "Male";
      await box.add(customer2);
      final customer3 = Customer()
        ..name = "Ingemarin Guleeford"
        ..email = "Ingemar@blogger.com"
        ..accountType = "Savings"
        ..balance = 4358
        ..gender = "Female";
      await box.add(customer3);
      final customer4 = Customer()
        ..name = "Wyn Smith"
        ..email = "Wyn@hotmail.com"
        ..accountType = "Savings"
        ..balance = 1820
        ..gender = "Female";
      await box.add(customer4);
      final customer5 = Customer()
        ..name = "Kate Diesel"
        ..email = "kate@Diesel.com"
        ..accountType = "Current"
        ..balance = 4550
        ..gender = "Male";
      await box.add(customer5);
      final customer6 = Customer()
        ..name = "Selina Yep"
        ..email = "yepselina@quest.com"
        ..accountType = "Savings"
        ..balance = 1308
        ..gender = "Female";
      await box.add(customer6);
      final customer7 = Customer()
        ..name = "John Blow"
        ..email = "john9870@yahoo.com"
        ..accountType = "Savings"
        ..balance = 2816
        ..gender = "Male";
      await box.add(customer7);
      final customer8 = Customer()
        ..name = "Jimmy Wright"
        ..email = "Jimmy@rest.com"
        ..accountType = "Savings"
        ..balance = 350
        ..gender = "Male";
      await box.add(customer8);
      final customer9 = Customer()
        ..name = "Eliana Paint"
        ..email = "elianan@hotmail.com"
        ..accountType = "Savings"
        ..balance = 4099
        ..gender = "Female";
      await box.add(customer9);
      final customer10 = Customer()
        ..name = "Cobra Retan"
        ..email = "cobrar@mapquest.com"
        ..accountType = "Savings"
        ..balance = 700
        ..gender = "Male";
      await box.add(customer10);
      final cList = box.values.toList();
      for (int i = 0; i < box.length; i++) {
        print(cList[i].name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("images/bank_homeScreen.png"),
              height: 230.0,
              width: 230.0,
            ),
            SizedBox(height: 50.0),
            Text("The No.1 Bank",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    color: Color(0xFF7cbb00))),
            SizedBox(height: 30.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color(0xFF333333), onPrimary: Color(0xFFFFFFFF)),
              child: Padding(
                  padding: EdgeInsets.all(10.0), child: Text("All Customers")),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AllCustomer2()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
