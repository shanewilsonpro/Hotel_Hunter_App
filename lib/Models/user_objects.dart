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

  String email;
  String bio;
  String city;
  String country;
  bool isHost;
  bool isCurrentlyHosting;

  List<Booking> bookings;
  List<Review> reviews;
  List<Conversation> conversations;
  List<Posting> savedPostings;

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
  }

  Future<void> getUserInfoFromFirestore() async {
    DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(id).get();
    this.firstName = snapshot['firstName'] ?? "";
    this.lastName = snapshot['lastName'] ?? "";
    this.email = snapshot['email'] ?? "";
    this.bio = snapshot['bio'] ?? "";
    this.city = snapshot['city'] ?? "";
    this.country = snapshot['country'] ?? "";
    this.isHost = snapshot['isHost'] ?? false;
    
    List<String> conversationIDs = List<String>.from(snapshot['conversationIDs']) ?? [];
    List<String> myPostingIDs = List<String>.from(snapshot['myPostingIDs']) ?? [];
    List<String> savedPostingIDs = List<String>.from(snapshot['savedPostingIDs']) ?? [];

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
