// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sq/screens/setting.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         automaticallyImplyLeading: true,
//         title: const Text(
//           'Home',
//           style: TextStyle(
//               fontSize: 20,
//               letterSpacing: 2,
//               color: Colors.green,
//               fontWeight: FontWeight.w500),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Get.to(const SettingScreen());
//           },
//           icon: Icon(Icons.settings, size: 25, color: Colors.cyan[700]),
//         ),
//       ),
//     );
//   }
// }






// class ChatScreen extends StatefulWidget {
//   const ChatScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<ChatScreen> {
//   String? selectedHelpMessage;
//   List<Message> chatLog = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('your own sq bot'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               reverse: true,
//               itemCount: chatLog.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 4.0, horizontal: 8.0),
//                   child: MessageBubble(message: chatLog[index]),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: DropdownButton<String>(
//                     value: selectedHelpMessage,
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         selectedHelpMessage = newValue!;
//                       });
//                     },
//                     items: <String>[
//                       'Who are you?',
//                       'Thank you!',
//                       'setting',
//                     ].map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     if (selectedHelpMessage != null) {
//                       sendMessage(selectedHelpMessage!);
//                     }
//                   },
//                   icon: Icon(Icons.send),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void sendMessage(String message) {
//     // Add user message to chat log
//     setState(() {
//       chatLog.insert(0, Message(text: message, isUser: true));
//     });

//     // Respond with bot message
//     String botResponse =
//         getBotResponse(message, context); // Pass the context here
//     if (botResponse.isNotEmpty) {
//       setState(() {
//         chatLog.insert(0, Message(text: botResponse, isUser: false));
//       });
//     }
//   }

  
//   String getBotResponse(String message, BuildContext context) {
//     // Basic logic for bot response
//      if (message == 'Who are you?') {
//       return 'I am SQ Bot!';
//     } else if (message == 'What is Flutter?') {
//       return 'Flutter is a UI toolkit from Google for building natively compiled applications for mobile, web, and desktop from a single codebase.';
//     } else if (message == 'Hello!') {
//       return 'Hello! How can I assist you?';
//     } else if (message == 'Thank you!') {
//       return 'You\'re welcome!';
//     } else if (message == 'setting') {
//       // Navigate to FlutterScreen
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => SettingScreen()),
//       );
//       // Return an empty string or some other response indicating navigation
//       return '';
//     } else {
//       return 'I\'m sorry, I didn\'t understand that.';
//     }
//   }
// }

// class Message {
//   final String text;
//   final bool isUser;

//   Message({required this.text, required this.isUser});
// }

// class MessageBubble extends StatelessWidget {
//   final Message message;

//   const MessageBubble({Key? key, required this.message}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
//         padding: EdgeInsets.all(12.0),
//         decoration: BoxDecoration(
//           color: message.isUser ? Colors.blue : Colors.grey.shade300,
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         child: Text(
//           message.text,
//           style: TextStyle(
//             color: message.isUser ? Colors.white : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sq/screens/chatbot/chatbot.dart';
// import 'package:sq/screens/chatbot/screen_nav_chatbot.dart';
// import 'package:sq/screens/setting.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         automaticallyImplyLeading: true,
//         title: const Text(
//           'Home',
//           style: TextStyle(
//               fontSize: 20,
//               letterSpacing: 2,
//               color: Colors.green,
//               fontWeight: FontWeight.w500),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Get.to(const SettingScreen());
//           },
//           icon: Icon(Icons.settings, size: 25, color: Colors.cyan[700]),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Color.fromARGB(255, 74, 74, 74),
//         onPressed: () {
//           Get.to(ChatScreen());
//         },
//         child: Icon(Icons.chat,color: Colors.cyan[700],),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sq/popup.dart';
import 'package:sq/screens/chatbot/chatbot.dart';
import 'package:sq/screens/chatbot/screen_nav_chatbot.dart';

import 'package:sq/screens/user/setting.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> categories = [
    'WebDev',
    'AppDev',
    'AI/ML',
    'Software Engineering',
    'DSA',
  ];

  final List<List<Website>> websitesByCategory = [
    // Web Development
    [
      Website(
        name: 'HTML',
        url: 'https://www.w3schools.com/html/default.asp',
        image: 'assets/logos/wlogo.png',
        category: 'Web Development',
      ),
      Website(
        name: 'CSS',
        url: 'https://www.w3schools.com/css/default.asp',
        image: 'assets/logos/wlogo.png',
        category: 'Web Development',
      ),
      Website(
        name: 'JAVASCRIPT',
        url: 'https://www.w3schools.com/js/default.asp',
        image: 'assets/logos/wlogo.png',
        category: 'Web Development',
      ),
      Website(
        name: 'PHP',
        url: 'https://www.geeksforgeeks.org/php/default.asp',
        image: 'assets/logos/wlogo.png',
        category: 'Web Development',
      ),
      Website(
        name: 'BOOTSTRAP',
        url: 'https://getbootstrap.com/docs/5.3/getting-started/introduction/',
        image: 'assets/logos/wlogo.png',
        category: 'Web Development',
      ),
      Website(
        name: 'REACT JS',
        url: 'https://www.w3schools.com/react/default.asp',
        image: 'assets/logos/wlogo.png',
        category: 'Web Development',
      ),
      Website(
        name: 'NEXT JS',
        url: 'https://nextjs.org/docs',
        image: 'assets/logos/wlogo.png',
        category: 'Web Development',
      ),
      Website(
        name: 'MONGO DB',
        url: 'https://www.w3schools.com/mongodb/',
        image: 'assets/logos/wlogo.png',
        category: 'Web Development',
      ),
      
      
      // Add more websites for Web Development category
    ],
    // App Development
    [
      Website(
        name: 'GitHub',
        url: 'https://github.com/',
        image: 'assets/logos/wlogo.png',
        category: 'App Development',
      ),
      Website(
        name: 'Medium',
        url: 'https://medium.com/',
        image: 'assets/logos/wlogo.png',
        category: 'App Development',
      ),
      // Add more websites for App Development category
    ],
    // Data Science
    [
      Website(
        name: 'Kaggle',
        url: 'https://www.kaggle.com/',
        image: 'assets/logos/wlogo.png',
        category: 'Data Science',
      ),
      Website(
        name: 'Towards Data Science',
        url: 'https://towardsdatascience.com/',
        image: 'assets/logos/wlogo.png',
        category: 'Data Science',
      ),
      // Add more websites for Data Science category
    ],
    // Software Engineering
    [
      Website(
        name: 'HackerRank',
        url: 'https://www.hackerrank.com/',
        image: 'assets/logos/wlogo.png',
        category: 'Software Engineering',
      ),
      Website(
        name: 'LeetCode',
        url: 'https://leetcode.com/',
        image: 'assets/logos/wlogo.png',
        category: 'Software Engineering',
      ),
      // Add more websites for Software Engineering category
    ],
    // DSA (Data Structures and Algorithms)
    [
      Website(
        name: 'InterviewBit',
        url: 'https://www.interviewbit.com/',
        image: 'assets/logos/wlogo.png',
        category: 'DSA',
      ),
      Website(
        name: 'Educative',
        url: 'https://www.educative.io/',
        image: 'assets/logos/wlogo.png',
        category: 'DSA',
      ),
      // Add more websites for DSA category
    ],
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: const Text(
          'Home',
          style: TextStyle(
              fontSize: 20,
              letterSpacing: 2,
              color: Colors.white,
              fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: () {
            Get.to(const SettingScreen());
          },
          icon: const Icon(Icons.menu, size: 25, color: Colors.white),
        ),
        
        backgroundColor: Colors.teal[600],
        elevation: 0,
        bottom: TabBar(
          
          labelStyle:const TextStyle(fontSize: 16),
          labelColor: const Color.fromARGB(255, 0, 72, 4),
          indicatorColor: Colors.black,
          dividerColor: Colors.amber[700],
          controller: _tabController,
          tabs: categories.map((category) => Tab(text: category)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: categories.map((category) {
          return ListView.builder(
            itemCount:
                websitesByCategory[categories.indexOf(category)].length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                child: InkWell(
                  onTap: () {
                    _launchURL(websitesByCategory[categories.indexOf(category)]
                            [index]
                        .url);
                  },
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.teal[400],
                    child: ListTile(
                      leading: SizedBox(
                        width: 60, // Adjust the width as needed
                        child: Image.asset(
                          websitesByCategory[categories.indexOf(category)][index]
                              .image,
                          fit: BoxFit.cover, // Adjust the fit as needed
                        ),
                      ),
                      title: Text(
                        websitesByCategory[categories.indexOf(category)][index]
                            .name,
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 118, 4),
                        ),
                      ),
                      subtitle: Text(
                        websitesByCategory[categories.indexOf(category)][index]
                            .category,
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 63, 63, 63),
                        ),
                      ),
                    
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(170, 255, 255, 255),
        onPressed: () {
      
          Get.to(const ChatBot());
          
        },
        child: Icon(Icons.search,color: Colors.cyan[700],),
      ),
    
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }
  
}

class Website {
  final String name;
  final String url;
  final String image;
  final String category;

  Website({
    required this.name,
    required this.url,
    required this.image,
    required this.category,
  });
}



