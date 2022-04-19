import 'package:assessmenttest_vimigo/Pages/contacts_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    // Returns HomePage
    return MaterialApp(
      routes: {
        // When navigating to the "contactsPage" route, build the ContactsPage widget.
        'contactsPage': (context) => const ContactsPage(),
      },
      initialRoute: "contactsPage",
      debugShowCheckedModeBanner: false,
    );
  }
}
