import 'package:assessmenttest_vimigo/Pages/contacts_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class tutorialPage extends StatefulWidget {
  const tutorialPage({Key? key}) : super(key: key);

  @override
  State<tutorialPage> createState() => _tutorialPageState();
}

class _tutorialPageState extends State<tutorialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              child: Text("This is the tutorial page."),
            ),
            TextButton(
              onPressed: () {
                // setTutorialState();
                Navigator.popAndPushNamed(context, "contactsPage");
              },
              child: Text("Close"),
            )
          ],
        ),
      ),
    );
  }

  setTutorialState() async {
    final SharedPreferences intro = await SharedPreferences.getInstance();
    intro.setBool("isNew", false);
  }
}
