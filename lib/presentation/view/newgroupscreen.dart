import 'package:chatroom_chatbot/presentation/view/widgets/custom_edit_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../data/model/chatgroup.dart';
import '../viewModel.dart';

final Logger _logger = Logger();

class NewChatGroupScreen extends ConsumerStatefulWidget {
  const NewChatGroupScreen({super.key});

  @override
  _NewChatGroupScreenState createState() => _NewChatGroupScreenState();
}

class _NewChatGroupScreenState extends ConsumerState<NewChatGroupScreen> {
  TextEditingController _groupNameController = TextEditingController();

  String _selectedGroupImage = ''; // Store the selected group image URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: CustomAppBar(
                title: 'New Group',
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
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[400],
                child: IconButton(
                  icon: Icon(Icons.add_a_photo_outlined,
                      color: Colors.white, size: 45),
                  onPressed: () {
                    // Handle profile image upload
                  },
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

          if (groupName.isNotEmpty || _selectedGroupImage.isNotEmpty) {
            final viewModel = ref.read(chatGroupsProvider);
            final newGroup = ChatGroup(
              id: 0,
              time: DateTime
                  .now()
                  .millisecondsSinceEpoch
                  .toString(),
              name: groupName,
              lastMessage: 'No messages yet',
              image: _selectedGroupImage, // Set the group image
            );

            _logger.d(newGroup);

            // viewModel.addChatGroup(groupName,_selectedGroupImage);
            Navigator.pop(context);
          }
        },
        child: Icon(Icons.check,color: Colors.white,),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Adjust the position as needed
    );
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }
}
