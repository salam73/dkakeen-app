import 'package:madayen/model/model.dart';
import 'package:madayen/widgets/account_widget.dart';
import 'package:flutter/material.dart';

class SectionSearch extends SearchDelegate<Widget> {
  final List<Account> accounts;

  SectionSearch(this.accounts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Account> filteringAccounts = accounts
        .where((account) =>
            account.title.contains(query) ||
            account.description.contains(query))
        .toList();

    return ListView(
      children: filteringAccounts
          .map((account) => GestureDetector(
                onTap: () {
                  //FIXME to close search bar after getting results
                  close(context, null);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountWidget(account: account),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    account.title,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                              ),
                              Hero(
                                tag: account.title,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(11.0),
                                  ),
                                  child: Image.network(
                                    account.pics[0],
                                    height:
                                        100, // need to see this line of code again
                                    //fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              account.address,
                              style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              account.hours,
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                              textDirection: TextDirection.rtl,
                            ),
                          )
                        ],
                      )),
                ),
              ))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Account> filteringAccounts = accounts
        .where((account) =>
            account.title.contains(query) ||
            account.description.contains(query))
        .toList();

    return ListView(
      children: filteringAccounts
          .map((account) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountWidget(account: account)),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    account.title,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                              ),
                              Hero(
                                tag: account.title,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(11.0),
                                  ),
                                  child: Image.network(
                                    account.pics[0],
                                    height:
                                        100, // need to see this line of code again
                                    //fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              account.address,
                              style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              account.hours,
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                              textDirection: TextDirection.rtl,
                            ),
                          )
                        ],
                      )),
                ),
              ))
          .toList(),
    );
  }
}
