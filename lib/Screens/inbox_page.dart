import 'package:flutter/material.dart';
import 'package:hotel_hunter_app/Screens/conversation_page.dart';
import 'package:hotel_hunter_app/Views/list_widgets.dart';

class InboxPage extends StatefulWidget {
  InboxPage({Key key}) : super(key: key);

  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: ListView.builder(
        itemCount: 2,
        itemExtent: MediaQuery.of(context).size.height / 7,
        itemBuilder: (context, index) {
          return InkResponse(
            child: ConversationListTile(),
            onTap: () {
              Navigator.pushNamed(
                context,
                ConversationPage.routeName,
              );
            },
            );
        },
      ),
      
    );
  }
}
