class UserModel {
  final String uid;
  final String name;
  final String avatar;
  final Map<String, dynamic> age;
  final String sex;
  final String city;
  final String bio;
  final String sexFind;

  final bool isOnline;

  final List<String> blocked;
  final List<String> liked;
  final List<String> pending;

  final List<String> tags;
  final bool isPrime;

  final String fcmToken;

  UserModel(
      {required this.uid,
      required this.name,
      required this.avatar,
      required this.age,
      required this.sex,
      required this.city,
      required this.bio,
      required this.sexFind,
      required this.isOnline,
      required this.blocked,
      required this.liked,
      required this.pending,
      required this.tags,
      required this.isPrime,
      required this.fcmToken
      });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'avatar': avatar,
      'age': age,
      'sex': sex,
      'city': city,
      'bio': bio,
      'sexFind': sexFind,
      'isOnline': isOnline,
      'blocked': blocked,
      'liked': liked,
      'pending': pending,
      'tags': tags,
      'isPrime': isPrime,
      'fcmToken': fcmToken
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        uid: map['uid'] ?? '',
        name: map['name'] ?? '',
        avatar: map['avatar'] ?? '',
        age: map['age'] ?? Map<String, dynamic>,
        sex: map['sex'] ?? '',
        city: map['city'] ?? '',
        bio: map['bio'] ?? '',
        sexFind: map['sexFind'] ?? '',
        isOnline: map['isOnline'] ?? false,
        blocked: List<String>.from(map['blocked']),
        liked: List<String>.from(map['liked']),
        pending: List<String>.from(map['pending']),
        tags: List<String>.from(map['tags']),
        isPrime: map['isPrime'] ?? false,
        fcmToken: map['fcmToken'] ?? '',
    );
  }
}