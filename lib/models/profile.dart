class Message {
  String userId;
  String senderEmail;
  String receiverId;
  String message;
  DateTime timeStamp;

  Message({
    required this.userId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timeStamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': userId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timeStamp': timeStamp,
    };
  }
}
