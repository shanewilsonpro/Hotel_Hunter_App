import 'package:flutter/material.dart';
import 'package:hotel_hunter_app/Models/app_constants.dart';
import 'package:hotel_hunter_app/Models/user_objects.dart';

class Review {

  Contact contact;
  String text;
  double rating;
  DateTime dateTime;

  Review();

  void createReview(Contact contact, String text, double rating, DateTime dateTime) {
    this.contact = contact;
    this.text = text;
    this.rating = rating;
    this.dateTime = dateTime;
  }
}