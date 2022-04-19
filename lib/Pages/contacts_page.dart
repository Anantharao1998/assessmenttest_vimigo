import 'dart:convert';
import 'package:assessmenttest_vimigo/Components/addContactBox.dart';
import 'package:assessmenttest_vimigo/Components/inputConstructor.dart';
import 'package:assessmenttest_vimigo/Components/searchDelegate.dart';
import 'package:assessmenttest_vimigo/Pages/contact_details.dart';
import 'package:assessmenttest_vimigo/Pages/introPage.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List _contacts = [];
  List<String> nameList = [];
  List<InputData> newList = [];
  bool? isNew;
  // Reads dataset from local JSON file "assets/contacts.json".
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/contacts.json');
    final data = await json.decode(response);
    setState(() {
      _contacts = data;
    });

    _contacts
        .map(
          (e) => newList.add(
            InputData(
                user: e["user"], phone: e["phone"], checkin: e["check-in"]),
          ),
        )
        .toList();
    getNames();
  }

  // Extracts username from the list of contacts information
  Future<void> getNames() async {
    setState(() {
      newList.sort(
        (a, b) => a.user.toLowerCase().compareTo(b.user.toLowerCase()),
      );
      _contacts.sort(
        (a, b) => a["user"].toLowerCase().compareTo(b["user"].toLowerCase()),
      );
    });
    nameList.clear();
    newList
        .map(
          (e) => nameList.add(e.user),
        )
        .toList();
  }

  @override
  void initState() {
    getStatus();
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isNew == false) {
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
                  showSearch(
                      context: context,
                      delegate: MyCustomDelegate(
                        searchResults: nameList,
                        contacts: newList,
                      ));
                },
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    newList = newList.reversed.toList();
                  });
                },
                icon: Icon(Icons.sort_by_alpha),
              )
            ],
          ),

          body: Center(
            child: ListView.builder(
                itemCount: newList.length,
                itemBuilder: (context, index) {
                  // converts datetime to "d MMM yyyy hh:mm a" format.
                  final formatDate = new DateFormat("d MMM yyyy hh:mm a");
                  String formattedDate = formatDate.format(
                    DateTime.parse(
                      newList[index].checkin,
                    ),
                  );
                  if (newList.isNotEmpty) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(
                                name: newList[index].user,
                                phoneNum: newList[index].phone,
                                checkIn: formattedDate),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            padding:
                                EdgeInsets.only(top: 40, left: 10, right: 10),
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
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
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
                                                    " ${newList[index].phone}",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                "${newList[index].user}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  {
                    return Center(
                        child: Text("Provided Contact List is Empty !!!"));
                  }
                }),
          ),
          floatingActionButton: Container(
              // Implement Sprite animation here
              ),
          bottomNavigationBar: BottomAppBar(
            child: InkWell(
              onTap: () async {
                final newContacts = await showDialog(
                    context: context,
                    builder: (context) {
                      return addContact(oldList: newList);
                    });

                if (newContacts.isNotEmpty) {
                  setState(() {
                    newList = newContacts;
                    getNames();

                    final snackBar = SnackBar(
                      content: const Text('Contact successfully added !!!'),
                      action: SnackBarAction(
                        label: '',
                        onPressed: () {},
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                }
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
    } else {
      return tutorialPage();
    }
  }

  getStatus() async {
    final SharedPreferences intro = await SharedPreferences.getInstance();
    setState(() {
      isNew = intro.getBool("isNew");
    });
  }
}
