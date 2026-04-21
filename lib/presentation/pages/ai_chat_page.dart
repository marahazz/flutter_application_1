// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AIChatPage extends StatefulWidget {
  const AIChatPage({super.key});

  @override
  State<AIChatPage> createState() => _AIChatPageState();
}

class _AIChatPageState extends State<AIChatPage> {
  final List<_ChatMessage> _messages = [
    _ChatMessage(isUser: false, text: 'مرحباً! كيف يمكنني مساعدتك في تقييم أو إصلاح سيارتك اليوم؟'),
  ];
  final TextEditingController _controller = TextEditingController();
  bool _sending = false;

  void _sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage(isUser: true, text: text));
      _sending = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _messages.add(_ChatMessage(isUser: false, text: _aiReply(text)));
      _sending = false;
    });
    _controller.clear();
  }

  String _aiReply(String userText) {
    // Mock AI reply logic
    if (userText.contains('تكلفة')) return 'تكلفة الإصلاح تعتمد على نوع الضرر. أرسل لي صورة أو تفاصيل أكثر.';
    if (userText.contains('ورش')) return 'يمكنك مقارنة الورش القريبة من خلال قسم "ورش الإصلاح".';
    if (userText.contains('بيع')) return 'تأثير الضرر على البيع يعتمد على شدته. أرسل لي صورة لأعطيك تقدير أفضل.';
    return 'سعيد بمساعدتك! يمكنك سؤالي عن أي شيء يخص تقييم أو إصلاح السيارات.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مساعد AUTONEXA الذكي'), backgroundColor: Colors.black),
      backgroundColor: const Color(0xFF181A20),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, i) => Align(
                alignment: _messages[i].isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _messages[i].isUser ? Colors.cyanAccent.withOpacity(0.18) : Colors.white.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(_messages[i].text, style: TextStyle(color: _messages[i].isUser ? Colors.cyanAccent : Colors.white)),
                ),
              ),
            ),
          ),
          if (_sending) const LinearProgressIndicator(minHeight: 2),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'اكتب سؤالك...'
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.cyanAccent),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final bool isUser;
  final String text;
  _ChatMessage({required this.isUser, required this.text});
}
