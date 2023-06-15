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

  var askindex = 0;
  var askindex2 = 0;

  late final ScrollController _scrollController;
  List<String> ww2Questions = [
  "When did World War II begin?",
  "Which countries were part of the Axis powers?",
  "What was the Holocaust?",
  "Who were the Allied powers?",
  "When did World War II end?",
  "What was the significance of D-Day?",
  "Who were the major leaders during World War II?",
  "What were some key battles of World War II?",
  "What was the Manhattan Project?",
  "How did World War II impact civilians?",
];
List<String> jewishLifeQuestions = [
  "Where were you living during the war?",
  "Were you forced to leave your home?",
  "Did you experience discrimination?",
  "Were your family imprisoned in concentration camps?",
  "Did you participate in any resistance activities?",
  "Did you receive any help from others?",
  "Were you separated from your family members?",
  "Did you lose any family members?",
  "How did you maintain your faith?",
];




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
                    Expanded(
                      child: HS_button(
                        text: ww2Questions[askindex],
                        onPressed: (){
                          _onSubmitted(ww2Questions[askindex]);
                          setState(() {
                             if (ww2Questions.length == askindex+1){
                              askindex=0;
                             }
                             else{                              
                              askindex++;
                              }
                            });
                        },
                        padding: 5.0,
                      ),
                    ),
                    Expanded(
                       child: HS_button(
                        text: jewishLifeQuestions[askindex2],
                        onPressed: (){
                          _onSubmitted(jewishLifeQuestions[askindex2]);
                         setState(() {
                             if (ww2Questions.length == askindex2+1){
                              askindex2=0;
                             }
                             else{                              
                              askindex2++;
                              }
                            });
                        },
                        padding: 5.0,
                      ),
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
