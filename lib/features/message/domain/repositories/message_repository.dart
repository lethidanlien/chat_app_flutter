import 'package:chat_app_flutter/core/common/models/message.dart';
import 'package:chat_app_flutter/features/message/domain/types/get_all_messages_return_type.dart';
import 'package:chat_app_flutter/features/message/data/sources/send_message_body.dart';

abstract interface class MessageRepository {
  Future<GetAllMessagesReturnType> getAllMessages(String chatId, int? before);

  Future<Message> getMessage(int messageId);
  Future<Message> recallMessage(int messageId);
  Future<bool> deleteMessage(int messageId);

  Future<Message> sendMessage(
    String chatId,
    SendMessageBody messageBody,
  );

  List<Message> getLocalMessages(String chatId);
  Future<bool> setLocalMessages(
    String chatId,
    List<Message> messages,
  );
}
