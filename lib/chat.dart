import 'package:app/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'constants.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<String> chatHistory = []; // Store chat history
  List<String> chatInputHistory = []; // Store chat history
  String url = '';
  String input_message = '';
  TextEditingController _textEditingController = TextEditingController();
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ChatBot'),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatHistory.length,
              itemBuilder: (context, index) {
                final inputMessage = chatInputHistory[index];
                final chatMessage = chatHistory[index];
                return Column(
                  children: [
                    ChatBubble(message: inputMessage),
                    chat_bot(message: chatMessage),
                  ],
                );
              }, 
              controller: _controller,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    onChanged: (value) {
                      setState(() {
                        input_message = value;
                        url = 'https://final-chabot.onrender.com/predict?message=' +
                            input_message.toString();
                      });
                    }, 
                    decoration: InputDecoration(
                      hintText: "Send Message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    width:
                        10), // Add some space between the text field and the button
                ElevatedButton(
                  onPressed: () async {
                    chatInputHistory.add(input_message.toString());
                    _textEditingController.clear();
                    if (input_message.isNotEmpty) {
                      final data = await fetchData(url);
                      final decoded = jsonDecode(data);
                      setState(() {
                        chatHistory.add(decoded['answer']);
                      });
                      // Scroll to the end of the list after updating chatHistory
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        _controller.animateTo(
                          _controller.position.maxScrollExtent,
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut,
                        );
                      });
                    } else {
                      print("Input message is empty");
                    }
                  },
                  child: Text('Send'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<String> fetchData(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
