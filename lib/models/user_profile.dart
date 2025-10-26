class UserProfile {
  String id;
  String name;
  int age;
  String gender;
  double heightCm;
  double weightKg;
  String email;

  UserProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.heightCm,
    required this.weightKg,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'gender': gender,
        'heightCm': heightCm,
        'weightKg': weightKg,
        'email': email,
      };

  static UserProfile fromJson(Map<String, dynamic> j) => UserProfile(
        id: j['id'],
        name: j['name'],
        age: j['age'],
        gender: j['gender'],
        heightCm: (j['heightCm'] as num).toDouble(),
        weightKg: (j['weightKg'] as num).toDouble(),
        email: j['email'],
      );
}
