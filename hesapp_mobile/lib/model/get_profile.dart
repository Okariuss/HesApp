import 'dart:convert';

class GetProfile {
    GetProfile({
        this.email,
        this.id,
        this.role,
        this.username,
    });

    String? email;
    int? id;
    String? role;
    String? username;

    factory GetProfile.fromRawJson(String str) => GetProfile.fromJson(json.decode(str));
    factory GetProfile.fromJson(Map<String, dynamic> json) => GetProfile(
        email: json["email"],
        id: json["id"],
        role: json["role"],
        username: json["username"],
    );
}