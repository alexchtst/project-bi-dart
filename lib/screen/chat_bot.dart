import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syndo/widgets/button/navigation_button.dart';
import 'package:syndo/widgets/chat/message.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final TextEditingController _questionController = TextEditingController();

  List<Map<String, String>> messages = [
    {"role": "bot", "content": "Halo, aku bot!"},
  ];

  void _addMessage(String role, String content) {
    setState(() {
      messages.add({"role": role, "content": content});
    });
  }

  Future<void> _sendMessage(String text) async {
    _addMessage("user", text);

    try {
      final response = await http.post(
        Uri.parse("https://project-bi-backend.vercel.app/chatbot"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"message": text}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply = data["reply"] ?? "Bot tidak merespon.";
        _addMessage("bot", reply);
        print(data["reply"]);
      } else {
        _addMessage("bot", "⚠️ Error: ${response.statusCode}");
      }
    } catch (e) {
      _addMessage("bot", "⚠️ Terjadi kesalahan: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.01,
          horizontal: MediaQuery.of(context).size.width * 0.02,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background0.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20.0),
                NavigationButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.35,
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03,
                    right: MediaQuery.of(context).size.width * 0.03,
                    top: MediaQuery.of(context).size.width * 0.08,
                    bottom: MediaQuery.of(context).size.width * 0.06,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/chat-background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children:
                          messages
                              .map(
                                (msg) => Message(
                                  role: msg["role"]!,
                                  content: msg["content"]!,
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(155, 255, 255, 255),
                      borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.lightbulb, color: Colors.amber),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              title: const Text("Tanyakan Sesuatu"),
                              content: TextField(
                                controller: _questionController,
                                decoration: const InputDecoration(
                                  hintText: "Ketik pertanyaanmu...",
                                  border: OutlineInputBorder(),
                                ),
                                maxLines: 3,
                              ),
                              actions: [
                                TextButton(
                                  child: const Text("Batal"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.send),
                                  label: const Text("Kirim"),
                                  onPressed: () {
                                    final text =
                                        _questionController.text.trim();
                                    if (text.isNotEmpty) {
                                      _sendMessage(text);
                                      _questionController.clear();
                                    }
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
