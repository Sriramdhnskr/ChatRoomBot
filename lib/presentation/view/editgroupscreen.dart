import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatroom_chatbot/presentation/view/widgets/custom_edit_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../data/model/chatgroup.dart';
import '../viewModel.dart';

final Logger _logger = Logger();

class EditChatGroupScreen extends ConsumerStatefulWidget {
  final ChatGroup chatGroup;

  EditChatGroupScreen({required this.chatGroup});

  @override
  _EditChatGroupScreenState createState() => _EditChatGroupScreenState();
}

class _EditChatGroupScreenState extends ConsumerState<EditChatGroupScreen> {

  late TextEditingController _groupNameController;
  late String _groupImage;

  @override
  void initState() {
    super.initState();
    _groupNameController = TextEditingController(text: widget.chatGroup.name);
    _groupImage = widget.chatGroup.image;
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: CustomAppBar(
                title: 'Edit Group',
                onBack: () => Navigator.pop(context),
                onTick: () => Navigator.pop(context),
              )),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              CachedNetworkImage(
                imageUrl: _groupImage,
                placeholder: (context, url) => CircleAvatar(
                  backgroundColor: Colors.grey, // Placeholder color
                  child: Icon(Icons.person),    // Placeholder icon
                  radius: 60,
                ),
                errorWidget: (context, url, error) => CircleAvatar(
                  backgroundColor: Colors.grey, // Placeholder color
                  child: Icon(Icons.person),    // Placeholder icon
                  radius: 60,
                ), // Error widget
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  backgroundImage: imageProvider,
                  radius: 60,
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _groupNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey,width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey,width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.blue,width: 2),
                    ), // Remove default border
                    hintText: 'Enter Group Name',
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          // Handle New Group button pressed
          final groupName = _groupNameController.text;

          if (groupName.isNotEmpty || _groupImage.isNotEmpty) {
            final viewModel = ref.read(chatGroupsProvider);

            final updatedChatGroup = ChatGroup(
              id: 0,
              time: widget.chatGroup.time,
              name: groupName,
              lastMessage: widget.chatGroup.lastMessage,
              image: _groupImage, // Set the group image
            );

            _logger.d("${updatedChatGroup}");

            print("Edited groupname : ${groupName} and ${updatedChatGroup}");

            viewModel.updateChatGroup(updatedChatGroup);
            Navigator.pop(context, updatedChatGroup);
          }
        },
        child: Icon(Icons.check,color: Colors.white,),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Adjust the position as needed
    );
  }
}
