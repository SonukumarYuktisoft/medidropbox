// To parse this JSON data, do
//
//     final doctorDetailModel = doctorDetailModelFromJson(jsonString);

import 'dart:convert';

DoctorDetailModel doctorDetailModelFromJson(String str) => DoctorDetailModel.fromJson(json.decode(str));

String doctorDetailModelToJson(DoctorDetailModel data) => json.encode(data.toJson());

class DoctorDetailModel {
    int? id;
    String? name;
    String? title;
    String? about;
    String? specialty;
    List<String>? services;
    dynamic phone;
    dynamic email;
    Address? address;
    List<String>? expertise;
    int? servedPatientCount;
    double? rating;
    String? profilePhotoUrl;
    bool? isActive;
    double? fees;  // Changed from int? to double?
    int? averageConsultationTime;
    bool? allowRemote;
    List<String>? language;
    int? hospitalId;
    String? hospitalName;
    List<dynamic>? awards;

    DoctorDetailModel({
        this.id,
        this.name,
        this.title,
        this.about,
        this.specialty,
        this.services,
        this.phone,
        this.email,
        this.address,
        this.expertise,
        this.servedPatientCount,
        this.rating,
        this.profilePhotoUrl,
        this.isActive,
        this.fees,
        this.averageConsultationTime,
        this.allowRemote,
        this.language,
        this.hospitalId,
        this.hospitalName,
        this.awards,
    });

    factory DoctorDetailModel.fromJson(Map<String, dynamic> json) => DoctorDetailModel(
        id: json["id"],
        name: json["name"],
        title: json["title"],
        about: json["about"],
        specialty: json["specialty"],
        services: json["services"] == null ? [] : List<String>.from(json["services"]!.map((x) => x)),
        phone: json["phone"],
        email: json["email"],
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        expertise: json["expertise"] == null ? [] : List<String>.from(json["expertise"]!.map((x) => x)),
        servedPatientCount: json["servedPatientCount"],
        rating: json["rating"]?.toDouble(),
        profilePhotoUrl: json["profilePhotoUrl"],
        isActive: json["isActive"],
        fees: json["fees"]?.toDouble(),  // Added .toDouble() for safety
        averageConsultationTime: json["averageConsultationTime"],
        allowRemote: json["allowRemote"],
        language: json["language"] == null ? [] : List<String>.from(json["language"]!.map((x) => x)),
        hospitalId: json["hospitalId"],
        hospitalName: json["hospitalName"],
        awards: json["awards"] == null ? [] : List<dynamic>.from(json["awards"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "title": title,
        "about": about,
        "specialty": specialty,
        "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
        "phone": phone,
        "email": email,
        "address": address?.toJson(),
        "expertise": expertise == null ? [] : List<dynamic>.from(expertise!.map((x) => x)),
        "servedPatientCount": servedPatientCount,
        "rating": rating,
        "profilePhotoUrl": profilePhotoUrl,
        "isActive": isActive,
        "fees": fees,
        "averageConsultationTime": averageConsultationTime,
        "allowRemote": allowRemote,
        "language": language == null ? [] : List<dynamic>.from(language!.map((x) => x)),
        "hospitalId": hospitalId,
        "hospitalName": hospitalName,
        "awards": awards == null ? [] : List<dynamic>.from(awards!.map((x) => x)),
    };
}

class Address {
    int? id;
    String? addressLine1;
    dynamic addressLine2;
    String? city;
    String? state;
    String? country;
    String? pincode;

    Address({
        this.id,
        this.addressLine1,
        this.addressLine2,
        this.city,
        this.state,
        this.country,
        this.pincode,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        pincode: json["pincode"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "city": city,
        "state": state,
        "country": country,
        "pincode": pincode,
    };
}