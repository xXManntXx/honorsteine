import 'package:dart_openai/dart_openai.dart';

import '../API_res/stolpersteineData.dart';
import '../models/chat_message.dart';

class ChatApi {
  static const _model = 'gpt-3.5-turbo';
  final StolpersteineData victim;

  ChatApi(this.victim) {
    OpenAI.apiKey = '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';
    OpenAI.organization = 'org-gVwQTIcO5W7krA4nu4FivnjD';
  }




  Future<String> completeChat(List<ChatMessage> messages) async {
    final chatCompletion = await OpenAI.instance.chat.create(
      model: _model,
      messages: messages
          .map((e) => OpenAIChatCompletionChoiceMessageModel(
                role: e.isUserMessage ? OpenAIChatMessageRole.user : OpenAIChatMessageRole.assistant,
                content: "Your are a victim of the nazis in the 2. world war. Your name is ${victim.name} and your were born in ${victim.city} on ${victim.address} in ${victim.birthDate}, you gender is ${victim.gender} and you died beacuse you were ${victim.reasonOfPersecussion} at ${victim.deathPlace} on the ${victim.deathDate}. If this description include 'Overlevende', you didn't die in world war 2. Please answer with this personality to the question and use I instead of your name: ${e.content}",
              ))
          .toList(),
    );
    return chatCompletion.choices.first.message.content;
  }
}
