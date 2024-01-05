class LoginModelClass {
  int status;
  bool success;
  String message;
  Data data;

  LoginModelClass({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory LoginModelClass.fromJson(Map<String, dynamic> json) => LoginModelClass(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String token;
  User user;

  Data({
    required this.token,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user.toJson(),
  };
}

class User {
  String id;
  String name;
  String email;
  DateTime? timestamp;
  int? v;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.timestamp,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    timestamp: DateTime.parse(json["timestamp"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "timestamp": timestamp?.toIso8601String(),
    "__v": v,
  };
}