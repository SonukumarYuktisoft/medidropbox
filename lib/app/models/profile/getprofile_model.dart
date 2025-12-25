// To parse this JSON data, do
//
//     final gerProfile = gerProfileFromJson(jsonString);

import 'dart:convert';

GerProfile gerProfileFromJson(String str) =>
    GerProfile.fromJson(json.decode(str));

String gerProfileToJson(GerProfile data) => json.encode(data.toJson());

class GerProfile {
  int? id;
  String? fullName;
  String? phone;
  String? email;
  String? profileImageUrl;
  String? aadharId;
  String? abhaId;
  Address? address;
  List<EmergencyContact>? emergencyContacts;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  GerProfile({
    this.id,
    this.fullName,
    this.phone,
    this.email,
    this.profileImageUrl,
    this.aadharId,
    this.abhaId,
    this.address,
    this.emergencyContacts,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory GerProfile.fromJson(Map<String, dynamic> json) => GerProfile(
    id: json["id"],
    fullName: json["fullName"],
    phone: json["phone"],
    email: json["email"],
    profileImageUrl: json["profileImageUrl"],
    aadharId: json["aadharId"],
    abhaId: json["abhaId"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    emergencyContacts: json["emergencyContacts"] == null
        ? []
        : List<EmergencyContact>.from(
            json["emergencyContacts"]!.map((x) => EmergencyContact.fromJson(x)),
          ),
    isActive: json["isActive"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "phone": phone,
    "email": email,
    "profileImageUrl": profileImageUrl,
    "aadharId": aadharId,
    "abhaId": abhaId,
    "address": address?.toJson(),
    "emergencyContacts": emergencyContacts == null
        ? []
        : List<dynamic>.from(emergencyContacts!.map((x) => x.toJson())),
    "isActive": isActive,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Address {
  int? id;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? country;
  String? pincode;
  double? latitude;
  double? longitude;
  String? locationUrl;

  Address({
    this.id,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.latitude,
    this.longitude,
    this.locationUrl,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    addressLine1: json["addressLine1"],
    addressLine2: json["addressLine2"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    pincode: json["pincode"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    locationUrl: json["locationUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "city": city,
    "state": state,
    "country": country,
    "pincode": pincode,
    "latitude": latitude,
    "longitude": longitude,
    "locationUrl": locationUrl,
  };
}

class EmergencyContact {
  int? id;
  String? personName;
  String? phone;
  String? relationship;
  String? email;
  bool? isPrimary;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  EmergencyContact({
    this.id,
    this.personName,
    this.phone,
    this.relationship,
    this.email,
    this.isPrimary,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) =>
      EmergencyContact(
        id: json["id"],
        personName: json["personName"],
        phone: json["phone"],
        relationship: json["relationship"],
        email: json["email"],
        isPrimary: json["isPrimary"],
        isActive: json["isActive"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "personName": personName,
    "phone": phone,
    "relationship": relationship,
    "email": email,
    "isPrimary": isPrimary,
    "isActive": isActive,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
