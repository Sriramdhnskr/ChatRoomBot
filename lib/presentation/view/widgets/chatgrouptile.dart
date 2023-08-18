import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/model/chatgroup.dart';



class ChatGroupTile extends StatefulWidget {
  final ChatGroup chatGroup;

  const ChatGroupTile(this.chatGroup, {super.key});

  @override
  State<ChatGroupTile> createState() => _ChatGroupTileState();
}

class _ChatGroupTileState extends State<ChatGroupTile> {

  bool isImageLoaded = false;

  String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    if (dateTime.isAfter(today)) {
      return DateFormat.jm().format(dateTime); // Time format
    } else if (dateTime.isAtSameMomentAs(today)) {
      return DateFormat.jm().format(dateTime); // Time format for today
    } else if (dateTime.isAtSameMomentAs(yesterday)) {
      return 'Yesterday'; // Yesterday
    } else {
      return DateFormat('dd/MM/yyyy').format(dateTime); // Date format
    }
  }

  @override
  Widget build(BuildContext context) {
    /*return ListTile(
      leading: CircleAvatar(
        child: Text(chatGroup.name[0]),
      ),
      title: Text(chatGroup.name),
      subtitle: Text(
        chatGroup.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(chatGroup.time),
      onTap: () {
        // Navigate to the chat screen of this group
      },
    );
*/

    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         /* CircleAvatar(
            backgroundImage: NetworkImage('https://picsum.photos/id/101/200/200'),
            // child: Text(chatGroup.name[0]),
            radius: 20,
          ),*/

          CachedNetworkImage(
            imageUrl: widget.chatGroup.image,
            placeholder: (context, url) => CircleAvatar(
              backgroundColor: Colors.grey, // Placeholder color
              child: Icon(Icons.person,color: Colors.white,),    // Placeholder icon
              radius: 20,
            ),
            errorWidget: (context, url, error) => CircleAvatar(
              backgroundColor: Colors.grey, // Placeholder color
              child: Icon(Icons.person,color: Colors.white,),    // Placeholder icon
              radius: 20,
            ), // Error widget
            imageBuilder: (context, imageProvider) => CircleAvatar(
              backgroundImage: imageProvider,
              radius: 20,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.chatGroup.name, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(
                  widget.chatGroup.lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          // Spacer(),
          Text(widget.chatGroup.time),
        ],
      ),
    );
  }
}
