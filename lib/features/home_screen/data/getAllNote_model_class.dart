class GetAllNoteModelClass {
  int? status;
  bool? success;
  String? message;
  List<Data>? data;

  GetAllNoteModelClass({
    this.status,
    this.success,
    this.message,
    this.data,
  });

  factory GetAllNoteModelClass.fromJson(Map<String, dynamic> json) => GetAllNoteModelClass(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: json["data"] != null
        ? List<Data>.from((json["data"] as List<dynamic>? ?? [])
        .map((x) => Data.fromJson(x)))
        : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Data {
  String? id;
  String? user;
  String? title;
  String? description;
  DateTime? timestamp;
  int? v;

  Data({
    this.id,
    this.user,
    this.title,
    this.description,
    this.timestamp,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    user: json["user"],
    title: json["title"],
    description: json["description"],
    timestamp: DateTime.parse(json["timestamp"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "title": title,
    "description": description,
    "timestamp": timestamp?.toIso8601String(),
    "__v": v,
  };
}