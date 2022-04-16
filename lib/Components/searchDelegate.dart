import 'package:assessmenttest_vimigo/Pages/contact_details.dart';
import 'package:flutter/material.dart';

class MyCustomDelegate extends SearchDelegate {
  MyCustomDelegate({required this.searchResults, required this.contacts});
  List<String> searchResults;
  List contacts;

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              // closes searchbar is field is empty.
              close(context, null);
            }
            {
              query = '';
            }
          },
          icon: Icon(Icons.clear),
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    List suggestions = searchResults
        .where((element) {
          final result = element.toLowerCase();
          final input = query.toLowerCase();

          return result.contains(input);
        })
        .toList()
        .cast<String>();
    // Returns username suggestions for the user's view.
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          String suggestion = suggestions[index];

          return ListTile(
            leading: Text(suggestion),
            onTap: () {
              query = suggestion;
              FocusScope.of(context).unfocus();
              close(context, null);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => DetailsPage(
                        name: suggestions[index],
                        phoneNum: contacts[index]["phone"],
                        checkIn: contacts[index]["check-in"],
                        needFormat: true,
                      )),
                ),
              );
            },
          );
        });
  }
}
