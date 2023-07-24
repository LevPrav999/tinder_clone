class ChatConversation {
  final String name;
  final String profilePic;
  final String contactId;
  final DateTime timeSent;
  final String lastMessage;

  final String fcmToken;

  ChatConversation(
      {required this.name,
      required this.profilePic,
      required this.contactId,
      required this.timeSent,
      required this.lastMessage,
      required this.fcmToken
      });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
      'fcmToken': fcmToken
    };
  }

  factory ChatConversation.fromMap(Map<String, dynamic> map) {
    return ChatConversation(
      name: map['name'] as String,
      profilePic: map['profilePic'] as String,
      contactId: map['contactId'] as String,
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
      lastMessage: map['lastMessage'] as String,
      fcmToken: map['fcmToken'] ?? ""
    );
  }
}
