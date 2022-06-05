class User {

  final bool isActive;
  final bool online;
  final String id;
  final String image;
  final String name;
  final String role;
  final String username;

  User({
    required this.id,
    required this.image,
    required this.isActive,
    required this.name,
    required this.online,
    required this.role,
    required this.username,
  });

  factory User.convertirJson(Map<String,dynamic>json)=> User(
    id      : json["_id"],
    image   : json["image"],
    isActive: json["isActive"],
    name    : json["name"],
    online  : json["online"],
    role    : json["role"],
    username: json["username"],
  );

  Map<String, dynamic> aJson() => {

    "_id"     : id,
    "image"   : image,
    "isActive": isActive,
    "name"    : name,
    "online"  : online,
    "role"    : role,
    "username": username,

  };
}