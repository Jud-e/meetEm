class ChatMessage {
  final String id;
  final String groupId;
  final String senderId;
  final String senderName;
  final String text;
  final DateTime sentAt;

  const ChatMessage({
    required this.id,
    required this.groupId,
    required this.senderId,
    required this.senderName,
    required this.text,
    required this.sentAt,
  });
}
