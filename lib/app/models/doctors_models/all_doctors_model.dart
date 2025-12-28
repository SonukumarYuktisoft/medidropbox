class AllDoctorsModel {
  final int id;
  final String name;
  final String title;
  final String about;
  final String specialty;
  final List<String> services;
  final String? phone; // Made nullable
  final String? email; // Made nullable
  final AddressModel address;
  final List<String> expertise;
  final int servedPatientCount;
  final double rating;
  final String profilePhotoUrl;
  final bool isActive;
  final double fees;
  final int averageConsultationTime;
  final bool allowRemote;
  final List<String> language;
  final int hospitalId;
  final String hospitalName;
  final List<dynamic> awards;

  AllDoctorsModel({
    required this.id,
    required this.name,
    required this.title,
    required this.about,
    required this.specialty,
    required this.services,
    this.phone, // Made optional
    this.email, // Made optional
    required this.address,
    required this.expertise,
    required this.servedPatientCount,
    required this.rating,
    required this.profilePhotoUrl,
    required this.isActive,
    required this.fees,
    required this.averageConsultationTime,
    required this.allowRemote,
    required this.language,
    required this.hospitalId,
    required this.hospitalName,
    required this.awards,
  });

  factory AllDoctorsModel.fromJson(Map<String, dynamic> json) {
    return AllDoctorsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      about: json['about'] ?? '',
      specialty: json['specialty'] ?? '',
      services: json['services'] != null 
          ? List<String>.from(json['services']) 
          : [],
      phone: json['phone'], // Can be null
      email: json['email'], // Can be null
      address: AddressModel.fromJson(json['address'] ?? {}),
      expertise: json['expertise'] != null 
          ? List<String>.from(json['expertise']) 
          : [],
      servedPatientCount: json['servedPatientCount'] ?? 0,
      rating: json['rating'] != null 
          ? (json['rating'] as num).toDouble() 
          : 0.0,
      profilePhotoUrl: json['profilePhotoUrl'] ?? '',
      isActive: json['isActive'] ?? false,
      fees: json['fees'] != null 
          ? (json['fees'] as num).toDouble() 
          : 0.0,
      averageConsultationTime: json['averageConsultationTime'] ?? 0,
      allowRemote: json['allowRemote'] ?? false,
      language: json['language'] != null 
          ? List<String>.from(json['language']) 
          : [],
      hospitalId: json['hospitalId'] ?? 0,
      hospitalName: json['hospitalName'] ?? '',
      awards: json['awards'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'about': about,
      'specialty': specialty,
      'services': services,
      'phone': phone,
      'email': email,
      'address': address.toJson(),
      'expertise': expertise,
      'servedPatientCount': servedPatientCount,
      'rating': rating,
      'profilePhotoUrl': profilePhotoUrl,
      'isActive': isActive,
      'fees': fees,
      'averageConsultationTime': averageConsultationTime,
      'allowRemote': allowRemote,
      'language': language,
      'hospitalId': hospitalId,
      'hospitalName': hospitalName,
      'awards': awards,
    };
  }

  // Helper method to get full address as string
  String get fullAddress {
    final addr = address;
    return '${addr.addressLine1}, ${addr.city}, ${addr.state} ${addr.pincode}';
  }

  // Helper method to check if contact info is available
  bool get hasContactInfo => phone != null || email != null;
}

class AddressModel {
  final int id;
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String state;
  final String country;
  final String pincode;

  AddressModel({
    required this.id,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? 0,
      addressLine1: json['addressLine1'] ?? '',
      addressLine2: json['addressLine2'],
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      pincode: json['pincode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'state': state,
      'country': country,
      'pincode': pincode,
    };
  }
}