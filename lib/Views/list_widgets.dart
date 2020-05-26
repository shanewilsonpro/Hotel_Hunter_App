import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:hotel_hunter_app/Models/app_constants.dart';
import 'package:hotel_hunter_app/Screens/view_profile_page.dart';

class ReviewListTile extends StatefulWidget {
  ReviewListTile({Key key}) : super(key: key);

  @override
  _ReviewListTileState createState() => _ReviewListTileState();
}

class _ReviewListTileState extends State<ReviewListTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile_demo.jpg'),
              radius: MediaQuery.of(context).size.width / 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: AutoSizeText(
                'Shane',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            StarRating(
              size: 25.0,
              starCount: 5,
              color: AppConstants.selectedIconColor,
              borderColor: Colors.grey,
              onRatingChanged: null,
              rating: 4.5,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
          child: AutoSizeText(
            'Great guy, really enjoed his stay at this place, would definitely recommend him to other people.',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
      ],
    );
  }
}

class ConversationListTile extends StatefulWidget {
  ConversationListTile({Key key}) : super(key: key);

  @override
  _ConversationListTileState createState() => _ConversationListTileState();
}

class _ConversationListTileState extends State<ConversationListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            ViewProfilePage.routeName,
          );
        },
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/default_avatar.png'),
          radius: MediaQuery.of(context).size.width / 14.0,
        ),
      ),
      title: Text(
        'Kevin',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22.5,
        ),
      ),
      subtitle: Text(
        'Hey, how\'s it going?',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      trailing: Text(
        'August 30',
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      contentPadding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
    );
  }
}

class MessageListTile extends StatelessWidget {
  MessageListTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 35, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                ViewProfilePage.routeName,
              );
            },
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/default_avatar.png'),
              radius: MediaQuery.of(context).size.width / 20,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'This is a really long message that is supposed to test if it looks decent in wrap lines',
                        textWidthBasis: TextWidthBasis.parent,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'September 1',
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    /*return Padding(
      padding: const EdgeInsets.fromLTRB(35, 15, 15, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'This is a really long message that is supposed to test if it looks decent in wrap lines',
                        textWidthBasis: TextWidthBasis.parent,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'September 1',
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                ViewProfilePage.routeName,
              );
            },
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/default_avatar.png'),
              radius: MediaQuery.of(context).size.width / 20,
            ),
          ),
        ],
      ),
    ); */
  }
}

class MyPostingListTile extends StatefulWidget {
  MyPostingListTile({Key key}) : super(key: key);

  @override
  _MyPostingListTileState createState() => _MyPostingListTileState();
}

class _MyPostingListTileState extends State<MyPostingListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(10.0),
      leading: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: AutoSizeText(
          'Awesome Apartment',
          maxLines: 2,
          minFontSize: 17.0,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      trailing: AspectRatio(
        aspectRatio: 3 / 2,
        child: Image(
          image: AssetImage('assets/images/apartment.jpg'),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}

class CreatePostingListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(Icons.add),
          ),
          Text(
            'Create a posting',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
