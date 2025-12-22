// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String? accessToken;
    String? refreshToken;
    String? tokenType;
    int? userId;
    String? username;
    String? role;
    bool? isFirstLogin;

    UserModel({
        this.accessToken,
        this.refreshToken,
        this.tokenType,
        this.userId,
        this.username,
        this.role,
        this.isFirstLogin,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        tokenType: json["tokenType"],
        userId: json["userId"],
        username: json["username"],
        role: json["role"],
        isFirstLogin: json["isFirstLogin"],
    );

    Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "tokenType": tokenType,
        "userId": userId,
        "username": username,
        "role": role,
        "isFirstLogin": isFirstLogin,
    };
}
