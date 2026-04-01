import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  String username;
  String email;
  String phoneNumber;
  String profilePicture;
  String gender;
  String dateOfBirth;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    this.gender = "",
    this.dateOfBirth = "",
  });

  /// Full name getter
  String get fullName => "$firstName $lastName";

  /// Formatted phone getter
  String get formattedPhoneNo =>
      AppFormatter.formatPhoneNumber(phoneNumber);

  /// Split full name
  static List<String> nameParts(String fullName) =>
      fullName.split(" ");

  /// Generate username
  static String generateUsername(String fullName) {
    List<String> parts = fullName.split(" ");

    String firstName = parts[0].toLowerCase();
    String lastName =
    parts.length > 1 ? parts[1].toLowerCase() : "";

    return "cwt_${firstName + lastName}";
  }

  /// Empty user
  static UserModel empty() => UserModel(
    id: "",
    firstName: "",
    lastName: "",
    username: "",
    email: "",
    phoneNumber: "",
    profilePicture: "",
    gender: "",
    dateOfBirth: "",
  );

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      "FirstName": firstName,
      "LastName": lastName,
      "Username": username,
      "Email": email,
      "PhoneNumber": phoneNumber,
      "ProfilePicture": profilePicture,
      "Gender": gender,
      "DateOfBirth": dateOfBirth,
    };
  }

  /// Create from Firestore snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {

    final data = document.data();

    if (data == null) {
      return UserModel.empty();
    }

    return UserModel(
      id: document.id,
      firstName: data["FirstName"] ?? "",
      lastName: data["LastName"] ?? "",
      username: data["Username"] ?? "",
      email: data["Email"] ?? "",
      phoneNumber: data["PhoneNumber"] ?? "",
      profilePicture: data["ProfilePicture"] ?? "",
      gender: data["Gender"] ?? "",
      dateOfBirth: data["DateOfBirth"] ?? "",
    );
  }
}