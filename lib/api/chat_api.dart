import 'package:dart_openai/dart_openai.dart';

import '../models/chat_message.dart';

class ChatApi {
  static const _model = 'gpt-3.5-turbo';

  ChatApi() {
    OpenAI.apiKey = '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';
    OpenAI.organization = 'org-gVwQTIcO5W7krA4nu4FivnjD';
  }

  Future<String> completeChat(List<ChatMessage> messages) async {
    final chatCompletion = await OpenAI.instance.chat.create(
      model: _model,
      messages: messages
          .map((e) => OpenAIChatCompletionChoiceMessageModel(
                role: e.isUserMessage ? OpenAIChatMessageRole.user : OpenAIChatMessageRole.assistant,
                content: e.content,
              ))
          .toList(),
    );
    return chatCompletion.choices.first.message.content;
  }
}
