import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sq/screens/user/setting.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? selectedHelpMessage;
  List<MyMessage> chatLog = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "SQ Help Desk",
          style: TextStyle(
            color: Colors.green,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: chatLog.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
                  child: MessageBubble(message: chatLog[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    hint: const Text(
                        '            . . . . . . . . select here . . . . . . . .'),
                    value: selectedHelpMessage,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedHelpMessage = newValue!;
                      });
                    },
                    items: <String>[
                      'Who are you?',
                      'Thank you!',
                      'Setting',
                      'chat services'
                    ].map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (selectedHelpMessage != null) {
                      sendMessage(selectedHelpMessage!);
                    }
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage(String message) {
    // Add user message to chat log
    setState(() {
      chatLog.insert(0, MyMessage(text: message, isUser: true));
    });

    // Respond with bot message
    String botResponse =
        getBotResponse(message, context); // Pass the context here
    if (botResponse.isNotEmpty) {
      setState(() {
        chatLog.insert(0, MyMessage(text: botResponse, isUser: false));
      });
    }
  }

  String getBotResponse(String message, BuildContext context) {
    // Basic logic for bot response
    if (message == 'Who are you?') {
      return 'I am SQ Bot!';
    } else if (message == 'Thank you!') {
      return 'You\'re welcome!';
    } else if (message == 'Setting') {
      // Navigate to FlutterScreen
      Get.to(const SettingScreen());
      // Return an empty string or some other response indicating navigation
      return '';
    } else if (message == 'chat services') {
      // Navigate to FlutterScreen
      Get.to(const ChatScreen());
      // Return an empty string or some other response indicating navigation
      return '';
    } else if (message == 'Hello! very') {
      return 'Hello! How can I assist you?';
    } else {
      return 'I\'m sorry, I didn\'t understand that.';
    }
  }
}

class MyMessage {
  final String text;
  final bool isUser;

  MyMessage({required this.text, required this.isUser});
}

class MessageBubble extends StatelessWidget {
  final MyMessage message;

  const MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color:
              message.isUser ? Colors.blue : const Color.fromARGB(182, 0, 0, 0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!message.isUser)
              const CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.air,
                  color: Color.fromARGB(255, 109, 171, 111),
                ),
              ), // Bot Icon
            const SizedBox(width: 8),
            Text(
              message.text,
              style: TextStyle(
                fontSize: message.isUser ? 16 : 14,
                fontWeight: message.isUser ? FontWeight.w500 : FontWeight.w400,
                color: message.isUser
                    ? Colors.white
                    : const Color.fromARGB(207, 196, 255, 173),
              ),
            ),
            if (message.isUser) const SizedBox(width: 8),
            if (message.isUser)
              const CircleAvatar(
                radius: 12,
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ), // User Icon
          ],
        ),
      ),
    );
  }
}
