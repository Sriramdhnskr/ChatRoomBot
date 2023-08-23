import 'package:chatroom_chatbot/presentation/view/widgets/custom_edit_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../data/model/chatgroup.dart';
import '../../data/model/member.dart';
import '../viewModel.dart';

final Logger _logger = Logger();

class NewChatMemberScreen extends ConsumerStatefulWidget {
  final ChatGroup chatGroup;

  const NewChatMemberScreen({required this.chatGroup});

  @override
  _NewChatMemberScreenState createState() => _NewChatMemberScreenState();
}

class _NewChatMemberScreenState extends ConsumerState<NewChatMemberScreen> {
  TextEditingController _OLMIdController = TextEditingController();

  String _selectedUserImage = ''; // Store the selected group image URL

  bool _isButtonEnabled = false;

  void _validateInput(String text) {
    String input = _OLMIdController.text;
    bool isValid = input.length == 8 && RegExp(r'^[a-zA-Z0-9]+$').hasMatch(input);
    setState(() {
      _isButtonEnabled = isValid;
    });
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
                title: 'Add Member',
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
                  controller: _OLMIdController,
                  onChanged: _validateInput,
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
                    hintText: 'Enter OLM ID',
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _isButtonEnabled ? Theme.of(context).primaryColor : Colors.grey,
        onPressed: _isButtonEnabled ? () async {
          // Handle New Group button pressed
          final OLMId = _OLMIdController.text;

          if (OLMId.isNotEmpty || _selectedUserImage.isNotEmpty) {
            final viewModel = ref.read(chatGroupsProvider);

            try {
              final user = await viewModel.getUser(OLMId);
              print('Username: ${user.username}');
              print('Image URL: ${user.image}');

              final newMember = Member(name: user.username,imageUrl: user.image,);

              _logger.d(newMember);

              viewModel.addMember(widget.chatGroup, newMember);

            } catch (e) {
              print('User not found.');
            }

            // viewModel.addChatGroup(groupName,_selectedGroupImage);
            Navigator.pop(context);
          }
        }
        : null,
        child: Icon(Icons.check,color: Colors.white,),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Adjust the position as needed
    );
  }

  @override
  void dispose() {
    _OLMIdController.dispose();
    super.dispose();
  }
}
