// To parse this JSON data, do
//
//     final allHospitalModel = allHospitalModelFromJson(jsonString);

import 'dart:convert';

List<AllHospitalModel> allHospitalModelFromJson(String str) => List<AllHospitalModel>.from(json.decode(str).map((x) => AllHospitalModel.fromJson(x)));

String allHospitalModelToJson(List<AllHospitalModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllHospitalModel {
    int? id;
    String? name;
    dynamic founder;
    DateTime? foundedOn;
    List<String>? images;
    Address? address;
    List<SocialMediaLink>? socialMediaLinks;
    bool? emergencyAvailable;
    String? country;
    List<String>? services;
    List<String>? facilities;
    dynamic emergencyCallNumber;
    dynamic bookingCallNumber;
    bool? isActive;
    dynamic adminUsername;

    AllHospitalModel({
        this.id,
        this.name,
        this.founder,
        this.foundedOn,
        this.images,
        this.address,
        this.socialMediaLinks,
        this.emergencyAvailable,
        this.country,
        this.services,
        this.facilities,
        this.emergencyCallNumber,
        this.bookingCallNumber,
        this.isActive,
        this.adminUsername,
    });

    factory AllHospitalModel.fromJson(Map<String, dynamic> json) => AllHospitalModel(
        id: json["id"],
        name: json["name"],
        founder: json["founder"],
        foundedOn: json["foundedOn"] == null ? null : DateTime.parse(json["foundedOn"]),
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        socialMediaLinks: json["socialMediaLinks"] == null ? [] : List<SocialMediaLink>.from(json["socialMediaLinks"]!.map((x) => SocialMediaLink.fromJson(x))),
        emergencyAvailable: json["emergencyAvailable"],
        country: json["country"],
        services: json["services"] == null ? [] : List<String>.from(json["services"]!.map((x) => x)),
        facilities: json["facilities"] == null ? [] : List<String>.from(json["facilities"]!.map((x) => x)),
        emergencyCallNumber: json["emergencyCallNumber"],
        bookingCallNumber: json["bookingCallNumber"],
        isActive: json["isActive"],
        adminUsername: json["adminUsername"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "founder": founder,
        "foundedOn": "${foundedOn!.year.toString().padLeft(4, '0')}-${foundedOn!.month.toString().padLeft(2, '0')}-${foundedOn!.day.toString().padLeft(2, '0')}",
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "address": address?.toJson(),
        "socialMediaLinks": socialMediaLinks == null ? [] : List<dynamic>.from(socialMediaLinks!.map((x) => x.toJson())),
        "emergencyAvailable": emergencyAvailable,
        "country": country,
        "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
        "facilities": facilities == null ? [] : List<dynamic>.from(facilities!.map((x) => x)),
        "emergencyCallNumber": emergencyCallNumber,
        "bookingCallNumber": bookingCallNumber,
        "isActive": isActive,
        "adminUsername": adminUsername,
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

class SocialMediaLink {
    int? id;
    String? platformName;
    String? profileUrl;

    SocialMediaLink({
        this.id,
        this.platformName,
        this.profileUrl,
    });

    factory SocialMediaLink.fromJson(Map<String, dynamic> json) => SocialMediaLink(
        id: json["id"],
        platformName: json["platformName"],
        profileUrl: json["profileUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "platformName": platformName,
        "profileUrl": profileUrl,
    };
}
