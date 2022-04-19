import 'package:assessmenttest_vimigo/Components/inputConstructor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class addContact extends StatelessWidget {
  addContact({required this.oldList, Key? key}) : super(key: key);
  List oldList;

  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  String dateTime = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AlertDialog(
        title: Text("Add New Contact"),
        content: Container(
          height: 450,
          width: 350,
          child: ListView(
            children: [
              Divider(
                thickness: 2,
                color: Colors.black54,
              ),
              ListTile(
                title: Text("Username"),
                subtitle: TextField(
                  controller: name,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              ListTile(
                title: Text("Phone"),
                subtitle: TextField(
                  controller: phoneNumber,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              ListTile(
                title: Text("Check-In"),
                subtitle: Container(
                  height: 200,
                  width: 350,
                  child: CupertinoTheme(
                    data: CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        dateTimePickerTextStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.dateAndTime,
                        onDateTimeChanged: (DateTime newDateTime) {
                          dateTime = newDateTime.toString();
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: (() => Navigator.pop(context)),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () =>
                onSubmit(name.text, phoneNumber.text, dateTime, context),
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }

  void onSubmit(String name, String num, String dateTime, context) {
    oldList.add(InputData(user: name, phone: num, checkin: dateTime));
    Navigator.of(context).pop(oldList);
  }
}
