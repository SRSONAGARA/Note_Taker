class RegisterModelClass {
  int status;
  bool success;
  String message;
  Data data;

  RegisterModelClass({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory RegisterModelClass.fromJson(Map<String, dynamic> json) => RegisterModelClass(
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
  String name;
  String email;
  String id;
  DateTime timestamp;
  int v;

  Data({
    required this.name,
    required this.email,
    required this.id,
    required this.timestamp,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    email: json["email"],
    id: json["_id"],
    timestamp: DateTime.parse(json["timestamp"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "_id": id,
    "timestamp": timestamp.toIso8601String(),
    "__v": v,
  };
}