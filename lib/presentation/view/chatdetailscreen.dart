import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatroom_chatbot/presentation/view/groupinfo.dart';
import 'package:chatroom_chatbot/presentation/view/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/chatgroup.dart';
import '../viewModel.dart';


class ChatDetailScreen extends ConsumerStatefulWidget {
  final ChatGroup chatGroup;

  ChatDetailScreen({required this.chatGroup});

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {


  @override
  void initState() {

      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        await ref.read(chatGroupsProvider).fetchChatGroup(widget.chatGroup.id!);
        // await ref.read(chatGroupsProvider).fetchUserProfiles();
        await ref.read(chatGroupsProvider).fetchChatMembers(widget.chatGroup.id!);
      });

    // ref.read(chatGroupsProvider).fetchChatGroup(widget.chatGroup.id!);
  }

  @override
  Widget build(BuildContext context) {

    // print(widget.chatGroup.toString());

    final _chatGroup = ref.watch(chatGroupsProvider).selectedChatGroup;
    final _membersA = ref.watch(chatGroupsProvider).members;

      print("member A is ${_membersA.toString()}");

    // final _members = ref.watch(chatGroupsProvider).userProfiles;
    // print("selected group ${_chatGroup.toString()}");


    return Scaffold(
      backgroundColor: Color(0xFFE57373),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Row(
              children: [
                /*CircleAvatar(
                    // backgroundImage: NetworkImage(widget.chatGroup.image),
                    child: Text(widget.chatGroup.name[0],),
                   radius: 24,
                  ),*/
                CachedNetworkImage(
                  imageUrl: _chatGroup.image,
                  placeholder: (context, url) => CircleAvatar(
                    backgroundColor: Colors.grey, // Placeholder color
                    child: Icon(Icons.person), // Placeholder icon
                    radius: 23,
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    backgroundColor: Colors.grey, // Placeholder color
                    child: Icon(Icons.person), // Placeholder icon
                    radius: 23,
                  ), // Error widget
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    backgroundImage: imageProvider,
                    radius: 23,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_chatGroup.name,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20)),
                    Text('${_membersA.length} members', style: TextStyle(color: Colors.grey[200],fontSize: 16)),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.info_outline, color: Colors.white),
                onPressed: () {
                  // Navigate to another screen or perform actions
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GroupInfoScreen(chatGroup: _chatGroup!,)));
                },
              ),
            ],
          ),
        ),
      ),
      body:/* ListView(children: [
        MessageBubble(message: widget.chatGroup.lastMessage, isUser: false)
      ]),*/

      Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: ListView(children: [
            MessageBubble(message: _chatGroup!.lastMessage, isUser: false)
          ]
      )
            ),
          ],
        ),
      ),
    );

  }


}
