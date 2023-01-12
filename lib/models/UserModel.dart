class UserModel {
  int? id;
  String? username;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? image;
  String? gender;
  String? nationality;
  String? bio;
  String? userType;
  String? accountStatus;
  String? notify;
  List<String>? tokens;
  String? authType;

  UserModel(
      {this.id,
      this.username,
      this.name,
      this.email,
      this.phone,
      this.password,
      this.image,
      this.gender,
      this.nationality,
      this.bio,
      this.userType,
      this.accountStatus,
      this.notify,
      this.tokens,
      this.authType});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    image = json['image'];
    gender = json['gender'];
    nationality = json['nationality'];
    bio = json['bio'];
    userType = json['userType'];
    accountStatus = json['accountStatus'];
    notify = json['notify'];
    tokens = json['tokens'].cast<String>();
    authType = json['authType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['image'] = this.image;
    data['gender'] = this.gender;
    data['nationality'] = this.nationality;
    data['bio'] = this.bio;
    data['userType'] = this.userType;
    data['accountStatus'] = this.accountStatus;
    data['notify'] = this.notify;
    data['tokens'] = this.tokens;
    data['authType'] = this.authType;
    return data;
  }
}
