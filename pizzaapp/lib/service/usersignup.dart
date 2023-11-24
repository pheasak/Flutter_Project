// ignore: camel_case_types
class userSignUp {
  final String user, email, password, date;
  userSignUp(
      {required this.date,
      required this.email,
      required this.password,
      required this.user});
  Map<String, dynamic> tomap() {
    return {
      'Name': user,
      'Email': email,
      'Password': password,
      'Date': date,
    };
  }
}
