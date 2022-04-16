import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List contacts = [
    {
      "user": "John Doe El Disousha",
      "phone": "0123456789",
      "check-in": "2020-06-30 16:10:05"
    },
    {
      "user": "John Cena",
      "phone": "0123434789",
      "check-in": "2020-02-30 10:10:05"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        FocusScope.of(context).unfocus();
      }),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF08D9D6),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 200,
                child: SearchField(
                  hint: "Search by Name.",
                  onTap: (value) => debugPrint(value.toString()),
                  suggestions: contacts
                      .map((e) => SearchFieldListItem<String>(e["user"]))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                String date = contacts[index]["check-in"];
                if (contacts.isNotEmpty) {
                  return Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 40, left: 10, right: 10),
                        child: Card(
                          color: Color(0xFFFFF4F4F4),
                          elevation: 5.0,
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: SizedBox(
                                    height: 50,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Phone :",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Text(
                                                " ${contacts[index]["phone"]}",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            child: Row(
                                          children: [
                                            Text(
                                              "Check-In :",
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              "${date}",
                                            ),
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Container(
                          constraints: BoxConstraints(minWidth: 50),
                          alignment: Alignment.centerLeft,
                          height: 50,
                          margin: EdgeInsets.fromLTRB(25, 10, 100, 0),
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFF08D9D6),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            "${contacts[index]['user']}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                {
                  return Center(
                      child: Text("Provided Contact List is Empty !!!"));
                }
              }),
        ),
        bottomNavigationBar: BottomAppBar(
          child: InkWell(
            onTap: () {
              debugPrint("Add User clicked !!!");
            },
            child: Container(
                color: Color(0xFF08D9D6),
                height: 60,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Click here to add new contact :"),
                    Icon(Icons.person_add),
                  ],
                ))),
          ),
        ),
      ),
    );
  }
}
