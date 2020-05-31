import 'package:flutter/material.dart';
import 'package:hotel_hunter_app/Models/app_constants.dart';
import 'package:hotel_hunter_app/Models/posting_objects.dart';
import 'package:hotel_hunter_app/Models/review_objects.dart';

class Contact {
  String firstName;
  String lastName;
  String imagePath;
  AssetImage displayImage;

  Contact({this.firstName = "", this.lastName = "", this.imagePath = ""}) {
    this.displayImage = AssetImage(this.imagePath);
  }

  String getFullName() {
    return this.firstName + " " + this.lastName;
  }

  User createUserFromContact() {
    return User(
      firstName: this.firstName,
      lastName: this.lastName,
      imagePath: this.imagePath,
    );
  }
}

class User extends Contact {
  String email;
  String bio;
  String city;
  String country;
  bool isHost;
  bool isCurrentlyHosting;

  List<Booking> bookings;
  List<Review> reviews;

  User(
      {String firstName = "",
      String lastName = "",
      String imagePath = "",
      this.email = "",
      this.bio = "",
      this.city = "",
      this.country = ""})
      : super(firstName: firstName, lastName: lastName, imagePath: imagePath) {
    this.isHost = false;
    this.isCurrentlyHosting = false;
    this.bookings = [];
    this.reviews = [];
  }

  void changeCurrentlyHosting(bool isHosting) {
    this.isCurrentlyHosting = isHosting;
  }

  void becomeHost() {
    this.isHost = true;
    this.changeCurrentlyHosting(true);
  }

  Contact createContactFromUser() {
    return Contact(
      firstName: this.firstName,
      lastName: this.firstName,
      imagePath: this.imagePath,
    );
  }

  void makeNewBooking(Booking booking) {
    this.bookings.add(booking);
  }

  double getCurrentRating() {
    if (this.reviews.length == 0) { return 4; }
    double rating = 0;
    this.reviews.forEach((review) { 
      rating += review.rating;
    });
    rating /= this.reviews.length;
    return rating;
  }

  void postNewReviews(String text, double rating) {
    Review newReview = Review();
    newReview.createReview(
      AppConstants.currentUser.createContactFromUser(),
      text,
      rating,
      DateTime.now(),
    );
    this.reviews.add(newReview);
  }
}
