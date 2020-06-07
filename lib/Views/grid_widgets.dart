import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:hotel_hunter_app/Models/app_constants.dart';
import 'package:hotel_hunter_app/Models/posting_objects.dart';

class PostingGridTile extends StatefulWidget {

  final Posting posting;
  
  PostingGridTile({this.posting, Key key}) : super(key: key);

  @override
  _PostingGridTileState createState() => _PostingGridTileState();
}

class _PostingGridTileState extends State<PostingGridTile> {

  Posting _posting;

  @override
  void initState() {
    this._posting = widget.posting;
    this._posting.getFirstImageFromStorage().whenComplete(() {
      setState(() {

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 3 / 2,
          child: (this._posting.displayImages.isEmpty) ? Container() : Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: this._posting.displayImages.first,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        AutoSizeText(
          "${_posting.type} - ${_posting.city}, ${_posting.country}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        AutoSizeText(
          'Awesome Apartment',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        Text('\$120 / night'),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            StarRating(
              size: 15.0,
              starCount: 5,
              color: AppConstants.selectedIconColor,
              borderColor: Colors.grey,
              onRatingChanged: null,
              rating: 4.5,
            ),
          ],
        ),
      ],
    );
  }
}

class TripGridTile extends StatefulWidget {

  final Booking booking;

  TripGridTile({this.booking, Key key}) : super(key: key);

  @override
  _TripGridTileState createState() => _TripGridTileState();
}

class _TripGridTileState extends State<TripGridTile> {

  Booking _booking;

  @override
  void initState() {
    this._booking = widget.booking;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 3 / 2,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/apartment.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        AutoSizeText(
          'Awesome Apartment',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        AutoSizeText(
          'Apartment - Los Angeles, CA',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        Text('\$120 / night'),
        Text(
          'August 10, 2019 -',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'August 12, 2019',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
