import 'package:flutter/material.dart';

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}

List<ChatMessage> messages = [
  ChatMessage(messageContent: "Hello, master", messageType: "receiver"),
];

void addChatmassage(String massage) {
  messages.add(ChatMessage(messageContent: massage, messageType: "sender"));
  switch (massage) {
    case 'hi':
      messages.add(ChatMessage(messageContent: 'hi', messageType: "receiver"));
      break;
    case 'help':
      messages.add(ChatMessage(
          messageContent: 'how can i help you?', messageType: "receiver"));
      break;
    case 'problem':
      messages.add(ChatMessage(
          messageContent: 'look like you face a problem what is it ?',
          messageType: "receiver"));
      break;
    case 'sign out':
      messages.add(ChatMessage(
          messageContent:
              'there a red button in the bottom of the menu hope your enjoy our application',
          messageType: "receiver"));
      break;
    case 'feedback':
      messages.add(ChatMessage(
          messageContent: 'go to feadback page', messageType: "receiver"));
      break;
    case 'how can i use this application':
      messages.add(ChatMessage(
          messageContent:
              'you select a specific hardware items and same for software then you go to the model page and check your list and click on create your list ',
          messageType: "receiver"));
      break;
    case 'how can i use this application?':
      messages.add(ChatMessage(
          messageContent:
              'you select a specific hardware items and same for software then you go to the model page and check your list and click on create your list ',
          messageType: "receiver"));
      break;

    default:
      messages.add(ChatMessage(
          messageContent:
              'i don\'t understand what you meaning for please try to ask mr another question ',
          messageType: "receiver"));
      break;
  }
}
