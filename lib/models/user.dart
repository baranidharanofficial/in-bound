class User {
  String? id;
  String uid;
  String name;
  String email;
  String phone;
  String location;
  String company;
  String role;
  int color; // Assuming color is represented as an integer
  String portfolio;
  String linkedin;
  String instagram;
  String? facebook;
  String? github;
  String? quora;
  String? medium;
  String? stack;
  String? x;
  List<String> connects; // List of friend IDs

  User({
    this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.company,
    required this.role,
    required this.color,
    required this.portfolio,
    required this.linkedin,
    required this.instagram,
    this.facebook,
    this.github,
    this.quora,
    this.medium,
    this.stack,
    this.x,
    required this.connects,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      location: json['location'],
      company: json['company'],
      role: json['role'],
      color: json['color'],
      portfolio: json['portfolio'],
      linkedin: json['linkedin'],
      instagram: json['instagram'],
      facebook: json['facebook'] ?? "",
      github: json['github'] ?? "",
      quora: json['quora'] ?? "",
      medium: json['medium'] ?? "",
      stack: json['stack'] ?? "",
      x: json['x'] ?? "",
      connects: List<String>.from(json['connects'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'location': location,
      'company': company,
      'role': role,
      'color': color,
      'portfolio': portfolio,
      'linkedin': linkedin,
      'instagram': instagram,
      'facebook': facebook,
      'github': github,
      'quora': quora,
      'medium': medium,
      'stack': stack,
      'x': x,
      'connects': connects,
    };
  }
}

class APIResponse {
  int statusCode;
  dynamic data;

  APIResponse({
    required this.statusCode,
    required this.data,
  });
}
