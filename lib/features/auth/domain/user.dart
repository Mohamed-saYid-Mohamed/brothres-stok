class AppUser {
  final String id;
  final String fullname;
  final String email;

  AppUser({required this.id, required this.fullname, required this.email});

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'].toString(),
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'fullname': fullname, 'email': email};
  }
}
