import 'package:flutter/material.dart';
import 'package:hotel_hunter_app/Views/list_widgets.dart';

class MyPostingsPage extends StatefulWidget {
  MyPostingsPage({Key key}) : super(key: key);

  @override
  _MyPostingsPageState createState() => _MyPostingsPageState();
}

class _MyPostingsPageState extends State<MyPostingsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: index == 2 ? CreatePostingListTile() : MyPostingListTile(),
            ),
          );
        },
      ),
    );
  }
}
