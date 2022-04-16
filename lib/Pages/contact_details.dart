import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage(
      {required this.name,
      required this.phoneNum,
      required this.checkIn,
      this.needFormat,
      Key? key})
      : super(key: key);
  String name, phoneNum, checkIn;
  bool? needFormat = false;

  @override
  Widget build(BuildContext context) {
    String formattedDate = checkIn;
    if (needFormat == true) {
      final formatDate = DateFormat("d MMM yyyy hh:mm a");
      formattedDate = formatDate.format(DateTime.parse(checkIn));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Details"),
        backgroundColor: Color(0xFF08D9D6),
      ),
      body: Container(
        height: 300,
        width: double.infinity,
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Card(
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(0xFF08D9D6),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "$name",
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Contact No. :"), Text("$phoneNum")],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Check-In :"), Text("$formattedDate")],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
