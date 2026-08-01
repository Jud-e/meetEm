import 'package:flutter/foundation.dart';
import '../models/chat_message.dart';
import 'current_user.dart';

/// In-memory chat store standing in for Firestore until real auth exists.
/// Same pattern as GroupRepository: swap this out once FirebaseAuth gives
/// us a real user id instead of the currentUserId placeholder.
class ChatRepository extends ChangeNotifier {
  ChatRepository._();
  static final instance = ChatRepository._();

  final Map<String, List<ChatMessage>> _messagesByGroup = {};

  List<ChatMessage> messagesForGroup(String groupId) => List.unmodifiable(_messagesByGroup[groupId] ?? const []);

  void sendMessage(String groupId, String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    final message = ChatMessage(
      id: 'm-${DateTime.now().microsecondsSinceEpoch}',
      groupId: groupId,
      senderId: currentUserId,
      senderName: currentUserName,
      text: trimmed,
      sentAt: DateTime.now(),
    );
    _messagesByGroup.putIfAbsent(groupId, () => []).add(message);
    notifyListeners();
  }
}