import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageBubble extends ConsumerWidget {

  const MessageBubble({required this.message, required this.isUser});

  final String message;
  final bool isUser;

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    return
      Column(
        crossAxisAlignment:
        isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 200),
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: isUser ? Colors.grey : Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(10),
                )),
            child: Text(message),
          ),
        ]);

  }
}


