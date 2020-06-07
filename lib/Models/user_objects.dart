import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hotel_hunter_app/Models/app_constants.dart';
import 'package:hotel_hunter_app/Models/messaging_objects.dart';
import 'package:hotel_hunter_app/Models/posting_objects.dart';
import 'package:hotel_hunter_app/Models/review_objects.dart';

class Contact {
  String id;
  String firstName;
  String lastName;
  MemoryImage displayImage;

  Contact({this.id = "", this.firstName = "", this.lastName = "", this.displayImage});

  Future<void> getContactInfoFromFirestore() async {
    DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(id).get();
    this.firstName = snapshot['firstName'] ?? "";
    this.lastName = snapshot['lastName'] ?? "";
  }

  Future<MemoryImage> getImageFromStorage() async {
    if (displayImage != null) { return displayImage; }
    final String imagePath = "userImages/${this.id}/profile_pic.jpg";
    final imageData = await FirebaseStorage.instance.ref().child(imagePath).getData(1024*1024);
    this.displayImage = MemoryImage(imageData);
    return this.displayImage;
  }

  String getFullName() {
    return this.firstName + " " + this.lastName;
  }

  User createUserFromContact() {
    return User(
      id: this.id,
      firstName: this.firstName,
      lastName: this.lastName,
      displayImage: this.displayImage,
    );
  }
}

class User extends Contact {

  DocumentSnapshot snapshot;
  String email;
  String bio;
  String city;
  String country;
  bool isHost;
  bool isCurrentlyHosting;
  String password;

  List<Booking> bookings;
  List<Review> reviews;
  List<Conversation> conversations;
  List<Posting> savedPostings;
  List<Posting> myPostings;

  User(
      {String id = "",
      String firstName = "",
      String lastName = "",
      MemoryImage displayImage,
      this.email = "",
      this.bio = "",
      this.city = "",
      this.country = ""})
      : super(id: id, firstName: firstName, lastName: lastName, displayImage: displayImage) {
    this.isHost = false;
    this.isCurrentlyHosting = false;
    this.bookings = [];
    this.reviews = [];
    this.conversations = [];
    this.savedPostings = [];
    this.myPostings = [];
  }

  Future<void> getUserInfoFromFirestore() async {
    DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(id).get();
    this.snapshot = snapshot;
    this.firstName = snapshot['firstName'] ?? "";
    this.lastName = snapshot['lastName'] ?? "";
    this.email = snapshot['email'] ?? "";
    this.bio = snapshot['bio'] ?? "";
    this.city = snapshot['city'] ?? "";
    this.country = snapshot['country'] ?? "";
    this.isHost = snapshot['isHost'] ?? false;

  }

  Future<void> getPersonalInfoFromFirestore() async {
    await getUserInfoFromFirestore();
    await getImageFromStorage();
    await getMyPostingsFromFirestore();
    await getSavedPostingsFromFirestore();
    await getAllBookingsFromFirestore();
  }

  Future<void> getMyPostingsFromFirestore() async {
    List<String> myPostingIDs = List<String>.from(snapshot['myPostingIDs']) ?? [];
    for (String postingID in myPostingIDs) {
      Posting newPosting = Posting(id: postingID);
      await newPosting.getPostingInfoFromFirestore();
      await newPosting.getAllBookingsFromFirestore();
      await newPosting.getAllImagesFromStorage();
      this.myPostings.add(newPosting);
    }
  }

  Future<void> getSavedPostingsFromFirestore() async {
    List<String> savedPostingIDs = List<String>.from(snapshot['savedPostingIDs']) ?? [];
    for (String postingID in savedPostingIDs) {
      Posting newPosting = Posting(id: postingID);
      await newPosting.getPostingInfoFromFirestore();
      await newPosting.getFirstImageFromStorage();
      this.savedPostings.add(newPosting);
    }
  }

  Future<void> addUserToFirestore() async {
    Map<String, dynamic> data = {
      "bio": this.bio,
      "city": this.city,
      "country": this.country,
      "email": this.email,
      "firstName": this.firstName,
      "isHost": false,
      "lastName": this.lastName,
      "myPostingIDs": [],
      "savedPostingIDs": [],
    };
    await Firestore.instance.document('users/${this.id}').setData(data);
  }

  Future<void> updateUserInFirestore() async {
    Map<String, dynamic> data = {
      "bio": this.bio,
      "city": this.city,
      "country": this.country,
      "firstName": this.firstName,
      "lastName": this.lastName,
    };
    await Firestore.instance.document('users/${this.id}').updateData(data);
  }

  Future<void> addImageToFirestore(File imageFile) async {
    StorageReference reference = FirebaseStorage.instance.ref().child('userImages/${this.id}/profile_pic.jpg');
    await reference.putFile(imageFile).onComplete;
    this.displayImage = MemoryImage(imageFile.readAsBytesSync());
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
      id: this.id,
      firstName: this.firstName,
      lastName: this.firstName,
      displayImage: this.displayImage,
    );
  }

  Future<void> getAllBookingsFromFirestore() async {
    this.bookings = [];
    QuerySnapshot snapshots = await Firestore.instance.collection('users/${this.id}/bookings').getDocuments();
    for (var snapshot in snapshots.documents) {
      Booking newBooking = Booking();
      await newBooking.getBookingInfoFromFirestoreFromUser(this.createContactFromUser(), snapshot);
      this.bookings.add(newBooking);
    }
  }

  void makeNewBooking(Booking booking) {
    this.bookings.add(booking);
  }

  void addSavedPosting(Posting posting) {
    this.savedPostings.add(posting);
  }

  void removeSavedPosting(Posting posting) {
    for (int i = 0; i < this.savedPostings.length; i++) {
      if (this.savedPostings[i].name == posting.name) {
        this.savedPostings.removeAt(1);
      }
    }
  }

  List<Booking> getPreviousTrips() {
    List<Booking> previousTrips = [];
    this.bookings.forEach((booking) {
      if(booking.dates.last.compareTo(DateTime.now()) <= 0) {
        previousTrips.add(booking);
      }
    });
  }

  List<Booking> getUpcomingTrips() {
    List<Booking> upcomingTrips = [];
    this.bookings.forEach((booking) { 
      if (booking.dates.last.compareTo(DateTime.now()) > 0) {
        upcomingTrips.add(booking);
      }
    });
    return upcomingTrips;
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
