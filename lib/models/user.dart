class User {
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
  String facebook;
  String github;
  String quora;
  String medium;
  String stack;
  String x;

  User({
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
    required this.facebook,
    required this.github,
    required this.quora,
    required this.medium,
    required this.stack,
    required this.x,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
      facebook: json['facebook'],
      github: json['github'],
      quora: json['quora'],
      medium: json['medium'],
      stack: json['stack'],
      x: json['x'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
