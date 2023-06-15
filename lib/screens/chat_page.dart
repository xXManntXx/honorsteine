import 'package:flutter/material.dart';

import '../API_res/stolpersteineData.dart';
import '../api/chat_api.dart';
import '../custom_widgets/HS_button.dart';
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
  late final List<ChatMessage> _messages;
  var _awaitingResponse = false;
  var _autoAnswer1 = "Tell me your story.";
  var _autoAnswer2 = "How did you experienced war ?";
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _messages = <ChatMessage>[
      ChatMessage(
          "Hello, I'm ${widget.victim.name}. Ask me anything about my story.",
          false),
    ];
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StolpersteineData>>(
        future: widget.allVictims,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(">>> Talking with ${widget.victim.name}");
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToBottom();
            });
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      ..._messages.map(
                        (msg) => MessageBubble(
                          content: msg.content,
                          isUserMessage: msg.isUserMessage,
                          victim: widget.victim,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    HS_button(
                      text: _autoAnswer1,
                      onPressed: (){
                        _onSubmitted(_autoAnswer1);
                      },
                      padding: 5.0,
                    ),
                    HS_button(
                      text: _autoAnswer2,
                      onPressed: (){
                        _onSubmitted(_autoAnswer2);
                      },
                      padding: 5.0,
                    ),
                  ],
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

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

}
