class User {
  String firstName;
  String lastName;
  String email;
  String password;
  String companyName;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.companyName,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'companyName': companyName,
    };
  }
}
