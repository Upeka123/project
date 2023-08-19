// To parse this JSON data, do
//
//     final usersHotels = usersHotelsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UsersHotels usersHotelsFromJson(String str) =>
    UsersHotels.fromJson(json.decode(str));

String usersHotelsToJson(UsersHotels data) => json.encode(data.toJson());

class UsersHotels {
  final int status;
  final List<Datum> data;

  UsersHotels({
    required this.status,
    required this.data,
  });

  factory UsersHotels.fromJson(Map<String, dynamic> json) => UsersHotels(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final int id;
  final String title;
  final String description;
  final String address;
  final String postcode;
  final String phoneNumber;
  final String latitude;
  final String longitude;
  final Image image;

  Datum({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.postcode,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
    required this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        address: json["address"],
        postcode: json["postcode"],
        phoneNumber: json["phoneNumber"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        image: Image.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "address": address,
        "postcode": postcode,
        "phoneNumber": phoneNumber,
        "latitude": latitude,
        "longitude": longitude,
        "image": image.toJson(),
      };
}

class Image {
  final String small;
  final String medium;
  final String large;

  Image({
    required this.small,
    required this.medium,
    required this.large,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        small: json["small"],
        medium: json["medium"],
        large: json["large"],
      );

  Map<String, dynamic> toJson() => {
        "small": small,
        "medium": medium,
        "large": large,
      };
}
