class Account {
  String? id; 
  String? fullName;
  String? photo;  
  String? email;
  String? password;
  String? phone; 
  String? type = ""; // user , tech , doyen ,admin

  // Private constructor
  Account._internal();

  // Single instance, initialized lazily
  static final Account _instance = Account._internal();

  // Factory constructor to return the instance
  factory Account() {
    return _instance;
  }

  // Serialization method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'photo': photo,
      'email': email,
      'password': password,
      'phone': phone,
      'type': type,
    };
  }

  // Deserialize method
  factory Account.fromJson(Map<String, dynamic> json) {
    var account = Account();
    account.id = json['id'];
    account.fullName = json['fullName'];
    account.photo = json['photo'];
    account.email = json['email'];
    account.password = json['password'];
    account.phone = json['phone'];
    account.type = json['type'];
    return account;
  }
}
