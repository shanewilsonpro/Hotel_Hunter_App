import 'package:flutter/material.dart';
import 'package:hotel_hunter_app/Models/posting_objects.dart';
import 'package:hotel_hunter_app/Screens/guest_home_page.dart';
import 'package:hotel_hunter_app/Views/calendar_widgets.dart';
import 'package:hotel_hunter_app/Views/text_widgets.dart';

class BookPostingPage extends StatefulWidget {
  
  final Posting posting;
  static final String routeName = '/book_posting_pageRoute';

  BookPostingPage({this.posting, Key key}) : super(key: key);

  @override
  _BookPostingPageState createState() => _BookPostingPageState();
}

class _BookPostingPageState extends State<BookPostingPage> {

  Posting _posting;
  List<CalendarMonthWidget> _calendarWidgets = [];
  List<DateTime> _bookedDates = [];

  void _buildCalendarWidgets() {
    _calendarWidgets = [];
    for (int i = 0; i < 12; i++) {
      _calendarWidgets.add(CalendarMonthWidget(monthIndex: i, bookedDates: _bookedDates));
    }
  }

  void _loadBookedDates() {
    _bookedDates = [];
    this._posting.getAllBookingsFromFirestore().whenComplete(() {
      this._bookedDates = this._posting.getAllBookedDates();
      this._buildCalendarWidgets();
    });
  }

  @override
  void initState() {
    this._posting = widget.posting;
    this._loadBookedDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'Book ${this._posting}'),
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
              child: (_calendarWidgets.isEmpty) ? Container() : PageView.builder(
                itemCount: _calendarWidgets.length,
                itemBuilder: (context, index) {
                  return _calendarWidgets[index];
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
