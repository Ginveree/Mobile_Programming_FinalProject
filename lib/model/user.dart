class User {
  String? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? address;
  String? otp;
  String? credit;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.phone,
      required this.address,
      required this.otp,
      required this.credit});

  User.fromJson(Map<String, dynamic> json) {
    id = json['user_id'];
    name = json['user_name'];
    email = json['user_email'];
    password = json['user_password'];
    phone = json['user_phone'];
    address = json['user_address'];
    otp = json['user_otp'];
    credit = json['user_credit'];
  }
}
