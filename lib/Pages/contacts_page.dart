import 'dart:convert';
import 'package:assessmenttest_vimigo/Components/searchDelegate.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List _contacts = [];
  List<String> nameList = [];
  // Reads dataset from local JSON file "assets/contacts.json".
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/contacts.json');
    final data = await json.decode(response);
    setState(() {
      _contacts = data;
      getNames();
    });
  }

  // Extracts username from the list of contacts information
  Future<void> getNames() async {
    debugPrint("Name List extraction initiated.");

    _contacts
        .map(
          (e) => nameList.add(e["user"]),
        )
        .toList();
  }

  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // To remove the keyboard when user clicks away from the keyboard.
      onTap: (() {
        FocusScope.of(context).unfocus();
      }),
      child: Scaffold(
        // SearchBar for the user to search by name.
        appBar: AppBar(
          backgroundColor: Color(0xFF08D9D6),
          title: Text(
            "Search by Name",
            style: TextStyle(
              color: Colors.black38,
              fontSize: 18,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                debugPrint(nameList.toString());
                showSearch(
                    context: context,
                    delegate: MyCustomDelegate(
                      searchResults: nameList,
                    ));
              },
            )
          ],
        ),

        body: Center(
          child: ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                // converts datetime to "d MMM yyyy hh:mm a" format.
                final formatDate = new DateFormat("d MMM yyyy hh:mm a");
                String formattedDate = formatDate.format(
                  DateTime.parse(
                    _contacts[index]["check-in"],
                  ),
                );
                if (_contacts.isNotEmpty) {
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
                                                " ${_contacts[index]["phone"]}",
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
                                              "${formattedDate}",
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
                            "${_contacts[index]['user']}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
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
