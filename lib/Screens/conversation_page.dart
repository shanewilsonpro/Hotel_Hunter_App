import 'package:flutter/material.dart';
import 'package:hotel_hunter_app/Views/list_widgets.dart';
import 'package:hotel_hunter_app/Views/text_widgets.dart';

class ConversationPage extends StatefulWidget {
  static final String routeName = '/conversation_pageRoute';

  ConversationPage({Key key}) : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'Kevin'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
              return MessageListTile();
            }),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 5 / 6,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Write a message',
                      contentPadding: EdgeInsets.all(20.0),
                      border: InputBorder.none,
                    ),
                    minLines: 1,
                    maxLines: 5,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    onPressed: () {},
                    child: Text(
                      'Send',
                      style: TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
