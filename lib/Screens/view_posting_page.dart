import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_hunter_app/Screens/guest_home_page.dart';
import 'package:hotel_hunter_app/Views/form_widget.dart';
import 'package:hotel_hunter_app/Views/list_widgets.dart';
import 'package:hotel_hunter_app/Views/text_widgets.dart';

class ViewPostingPage extends StatefulWidget {
  static final String routeName = '/view_posting_pageRoute';

  ViewPostingPage({Key key}) : super(key: key);

  @override
  _ViewPostingPageState createState() => _ViewPostingPageState();
}

class _ViewPostingPageState extends State<ViewPostingPage> {
  List<String> _amenities = [
    'Hair dryer',
    'Dishwasher',
    'Iron',
    'Wifi',
    'Carport',
  ];

  LatLng _centerLatLong = LatLng(34.0522, -118.2437);
  Completer<GoogleMapController> _completer;

  @override
  void initState() {
    _completer = Completer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'Posting Information'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 3 / 2,
              child: PageView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Image(
                      image: AssetImage('assets/images/apartment.jpg'),
                      fit: BoxFit.fill,
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 1.75,
                            child: AutoSizeText(
                              'Awesome Apartment',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          MaterialButton(
                            color: Colors.redAccent,
                            onPressed: () {},
                            child: Text(
                              'Book now',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            '\$120 / night',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0, bottom: 25.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 1.75,
                          child: AutoSizeText(
                            'A quiet, cozy place in the heart of the city. Easy to get to wherever you need to go!',
                            style: TextStyle(),
                            minFontSize: 18.0,
                            maxFontSize: 22.0,
                            maxLines: 5,
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: MediaQuery.of(context).size.width / 12.5,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/images/profile_demo.jpg'),
                                radius: MediaQuery.of(context).size.width / 13,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                'Shane Wilson',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        PostingInfoTile(
                          iconData: Icons.home,
                          category: 'Apartment',
                          categoryInfo: '2 guests',
                        ),
                        PostingInfoTile(
                          iconData: Icons.hotel,
                          category: '1 Bedroom',
                          categoryInfo: '1 King',
                        ),
                        PostingInfoTile(
                          iconData: Icons.wc,
                          category: '1 Bathroom',
                          categoryInfo: '1 full',
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Amenities',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 4 / 1,
                      children: List.generate(
                        _amenities.length,
                        (index) {
                          return Text(
                            _amenities[index],
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Text(
                    'The Location',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                    child: Text(
                      '111 West Broadway, Los Angeles, CA',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: GoogleMap(
                        onMapCreated: (controller) {
                          _completer.complete(controller);
                        },
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: _centerLatLong,
                          zoom: 14,
                        ),
                        markers: <Marker> {
                          Marker(
                            markerId: MarkerId('Home Location'),
                            position: _centerLatLong,
                            icon: BitmapDescriptor.defaultMarker,
                          )
                        }
                      ),
                    ),
                  ),
                  Text(
                    'Reviews',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ReviewForm(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: ListView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: ReviewListTile(),
                        );
                      },
                    ),
                  ),
                  //ListView.builder(itemBuilder: null),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostingInfoTile extends StatelessWidget {
  final IconData iconData;
  final String category;
  final String categoryInfo;

  PostingInfoTile({Key key, this.iconData, this.category, this.categoryInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        this.iconData,
        size: 30.0,
      ),
      title: Text(
        category,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
        ),
      ),
      subtitle: Text(
        categoryInfo,
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
    );
  }
}
