// To parse this JSON data, do
//
//     final phoneNumber = phoneNumberFromJson(jsonString);

import 'dart:convert';

PhoneNumber phoneNumberFromJson(String str) => PhoneNumber.fromJson(json.decode(str));

String phoneNumberToJson(PhoneNumber data) => json.encode(data.toJson());

class PhoneNumber {
  bool? status;
  String? message;
  Data? data;

  PhoneNumber({
    this.status,
    this.message,
    this.data,
  });

  factory PhoneNumber.fromJson(Map<String, dynamic> json) => PhoneNumber(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? idSocial;
  String? fullName;
  String? email;
  String? address1;
  String? address2;
  String? phoneNumber;
  String? maritalStatus;
  String? onlineStatus;
  String? idEthnicity;
  DateTime? birthDate;
  int? noKids;
  String? mobileStatus;
  String? role;
  String? referrallCode;
  String? idStatus;
  String? latitude;
  String? longitude;
  String? userType;
  String? selfiStatus;
  String? userStatus;
  int? age;
  String? city;
  String? height;
  String? weight;
  String? instagram;
  String? youtube;
  String? facebook;
  String? twitter;
  String? about;
  dynamic idCardPrimary;
  String? hobbiesAndInterest;
  String? backgroundImage;
  String? profileImage;
  String? status;

  Data({
    this.id,
    this.idSocial,
    this.fullName,
    this.email,
    this.address1,
    this.address2,
    this.phoneNumber,
    this.maritalStatus,
    this.onlineStatus,
    this.idEthnicity,
    this.birthDate,
    this.noKids,
    this.mobileStatus,
    this.role,
    this.referrallCode,
    this.idStatus,
    this.latitude,
    this.longitude,
    this.userType,
    this.selfiStatus,
    this.userStatus,
    this.age,
    this.city,
    this.height,
    this.weight,
    this.instagram,
    this.youtube,
    this.facebook,
    this.twitter,
    this.about,
    this.idCardPrimary,
    this.hobbiesAndInterest,
    this.backgroundImage,
    this.profileImage,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    idSocial: json["id_social"],
    fullName: json["full_name"],
    email: json["email"],
    address1: json["address1"],
    address2: json["address2"],
    phoneNumber: json["phone_number"],
    maritalStatus: json["marital_status"],
    onlineStatus: json["online_status"],
    idEthnicity: json["id_ethnicity"],
    birthDate: json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
    noKids: json["no_kids"],
    mobileStatus: json["mobile_status"],
    role: json["role"],
    referrallCode: json["referrall_code"],
    idStatus: json["id_status"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    userType: json["user_type"],
    selfiStatus: json["selfi_status"],
    userStatus: json["user_status"],
    age: json["age"],
    city: json["city"],
    height: json["height"],
    weight: json["weight"],
    instagram: json["instagram"],
    youtube: json["youtube"],
    facebook: json["facebook"],
    twitter: json["twitter"],
    about: json["about"],
    idCardPrimary: json["id_card_primary"],
    hobbiesAndInterest: json["hobbies_and_Interest"],
    backgroundImage: json["background_image"],
    profileImage: json["profile_image"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_social": idSocial,
    "full_name": fullName,
    "email": email,
    "address1": address1,
    "address2": address2,
    "phone_number": phoneNumber,
    "marital_status": maritalStatus,
    "online_status": onlineStatus,
    "id_ethnicity": idEthnicity,
    "birth_date": "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
    "no_kids": noKids,
    "mobile_status": mobileStatus,
    "role": role,
    "referrall_code": referrallCode,
    "id_status": idStatus,
    "latitude": latitude,
    "longitude": longitude,
    "user_type": userType,
    "selfi_status": selfiStatus,
    "user_status": userStatus,
    "age": age,
    "city": city,
    "height": height,
    "weight": weight,
    "instagram": instagram,
    "youtube": youtube,
    "facebook": facebook,
    "twitter": twitter,
    "about": about,
    "id_card_primary": idCardPrimary,
    "hobbies_and_Interest": hobbiesAndInterest,
    "background_image": backgroundImage,
    "profile_image": profileImage,
    "status": status,
  };
}
