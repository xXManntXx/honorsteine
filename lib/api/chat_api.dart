import 'package:chatgpt_client/models/chat_message.dart';
import 'package:dart_openai/openai.dart';

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
                role: e.isUserMessage ? 'user' : 'assistant',
                content: e.content,
              ))
          .toList(),
    );
    return chatCompletion.choices.first.message.content;
  }
}
