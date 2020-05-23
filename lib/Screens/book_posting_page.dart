import 'package:flutter/material.dart';
import 'package:hotel_hunter_app/Screens/guest_home_page.dart';
import 'package:hotel_hunter_app/Views/calendar_widgets.dart';
import 'package:hotel_hunter_app/Views/text_widgets.dart';

class BookPostingPage extends StatefulWidget {
  static final String routeName = '/book_posting_pageRoute';

  BookPostingPage({Key key}) : super(key: key);

  @override
  _BookPostingPageState createState() => _BookPostingPageState();
}

class _BookPostingPageState extends State<BookPostingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'Book a Posting'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Sun'),
                Text('Mon'),
                Text('Tue'),
                Text('Wed'),
                Text('Thur'),
                Text('Fri'),
                Text('Sun'),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.8,
              child: PageView.builder(
                itemCount: 12,
                itemBuilder: (context, index) {
                  return CalendarMonthWidget(
                    monthIndex: index,
                  );
                },
              ),
            ),
            MaterialButton(
              onPressed: () {},
              child: Text('Book Now!'),
              minWidth: double.infinity,
              height: MediaQuery.of(context).size.height / 14,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
