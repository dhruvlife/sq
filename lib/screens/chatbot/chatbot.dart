import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


import 'package:sq/screens/chatbot/messages_controller.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  _ChatState createState() => _ChatState();
}

class _ChatState extends State<ChatBot> {
  late DialogFlowtter dialogFlowtter;

  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(" ChatBot",
        style: TextStyle(
              fontSize: 20,
              letterSpacing: 2,
              color: Colors.green,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        
        child: Column(
          children: [
            Expanded(child: MessagesScreen(messages: messages)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                decoration:BoxDecoration(borderRadius: BorderRadius.circular(40)),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(hintText: 'Ask query on your own bot'),
                          controller: _controller,
                          style: const TextStyle(fontSize: 16)),
                    ),
                    IconButton(
                        onPressed: () {
                          sendMessages(_controller.text);
                          _controller.clear();
                        },
                        icon: const Icon(Icons.send,color: Color.fromARGB(255, 105, 105, 105),))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


// this is my one
  sendMessages(String text) async {
    if (text.isEmpty) {
      print(" Messages is empty");
    } else {
      try {
        setState(() {
          addMessages(Message(text: DialogText(text: [text])),
              true); //here we are handling the user messagehi
        });

        DetectIntentResponse? response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)),
        );
        if (response.message == null) {
          // Handle the case where the response is null
          print("Error: Dialogflow response was null");
          return;
        }
        setState(() {
          addMessages(response
              .message!); // here we are handling the dialogflowtter message
        });
      } catch (error) {
        // Handle other potential errors
        print("Error: $error");
      }
    }
  }

  addMessages(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}