import 'package:flutter/material.dart';


class MessagesScreen extends StatefulWidget {
  final List messages;
  const MessagesScreen({Key? key, required this.messages}) : super(key: key);

  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    var W = MediaQuery.of(context).size.width;
    return ListView.separated(
        itemBuilder: (context, index) {

          // final message = widget.messages[index];
          // final isUserMessage = message['isUserMessage'] ?? false;
          // final text = message['Message']?['text']?[0] ?? '';

          // // Check if text is null
          // if (text == null) {
          //   return SizedBox.shrink();
          // }

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 3,horizontal: 14),
            child: Row(
                mainAxisAlignment: widget.messages[index]['isUserMessage']
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical:10, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(
                          20,
                        ),
                        topRight: const Radius.circular(
                          20,
                        ),
                        bottomRight: Radius.circular(
                            widget.messages[index]['isUserMessage'] ? 0 : 20),
                        topLeft: Radius.circular(
                            widget.messages[index]['isUserMessage'] ? 20 : 0),
                      ),
                      color: widget.messages[index]['isUserMessage']
                          ? const Color.fromARGB(116, 0, 146, 149)
                          : const Color.fromARGB(174, 98, 255, 103)
                    ),
                    constraints: BoxConstraints(maxWidth: W * 2/ 3),
                    child: Text(widget.messages[index]['message'].text.text[0]),
                  ),
                ]),
          );
        },
        separatorBuilder: (_ , i ) => const Padding(padding: EdgeInsets.only(top: 10)),
        itemCount: widget.messages.length);
  }
}
