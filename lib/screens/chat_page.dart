import 'package:flutter/material.dart';

import '../API_res/stolpersteineData.dart';
import '../api/chat_api.dart';
import '../models/chat_message.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_composer.dart';

class ChatPage extends StatefulWidget {
  ChatPage({
    required this.chatApi,
    required this.allVictims,
    required this.victim,
    super.key,
  });

  final ChatApi chatApi;
  final Future<List<StolpersteineData>> allVictims;
  final StolpersteineData victim;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messages = <ChatMessage>[
    ChatMessage('Hello, how can I help?', false),
  ];
  var _awaitingResponse = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StolpersteineData>>(
        future: widget.allVictims,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //todo give chatAPI the data from victim there
            print(">>> Talking with ${widget.victim.name}");
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      ..._messages.map(
                        (msg) => MessageBubble(
                          content: msg.content,
                          isUserMessage: msg.isUserMessage,
                        ),
                      ),
                    ],
                  ),
                ),
                MessageComposer(
                  onSubmitted: _onSubmitted,
                  awaitingResponse: _awaitingResponse,
                ),
              ],
            );
          } else if (snapshot.hasError) {
            print('>>> Error : ${snapshot.error}');
            return Text('error : ${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        });
  }

  Future<void> _onSubmitted(String message) async {
    setState(() {
      _messages.add(ChatMessage(message, true));
      _awaitingResponse = true;
    });
    try {
      final response = await widget.chatApi.completeChat(_messages);
      setState(() {
        _messages.add(ChatMessage(response, false));
        _awaitingResponse = false;
      });
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again.')),
      );
      setState(() {
        _awaitingResponse = false;
      });
    }
  }
}
