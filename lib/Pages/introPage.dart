import 'package:assessmenttest_vimigo/Components/introCarousel.dart';
import 'package:assessmenttest_vimigo/Pages/contacts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
      backgroundColor: Color.fromARGB(255, 25, 152, 184),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              "Welcome to the Tutorial Page.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            "Tutorial contains 8 pages.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          introCarousel(),
        ],
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
        ),
        onPressed: () {
          setTutorialState();
          Navigator.popAndPushNamed(context, "contactsPage");
        },
        child: const Text(
          "Close",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  setTutorialState() async {
    final SharedPreferences intro = await SharedPreferences.getInstance();
    intro.setBool("isNew", false);
  }
}
