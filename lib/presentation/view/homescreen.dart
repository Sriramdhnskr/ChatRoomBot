import 'package:chatroom_chatbot/presentation/view/newgroupscreen.dart';
import 'package:chatroom_chatbot/presentation/view/widgets/chatgrouptile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../data/model/chatgroup.dart';
import '../viewModel.dart';
import 'chatdetailscreen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late List<ChatGroup> filteredGroups;
 
  String searchQuery = '';


 /* @override
  void initState() {
    super.initState();
    chatGroups = ref.watch(chatGroupsProvider).chatGroups;
    filteredGroups = chatGroups;
  }*/

  void filterGroups(List<ChatGroup> chatGroups) {
    setState(() {
      if (searchQuery.isNotEmpty) {
        filteredGroups = chatGroups.where((group) {
          return group.name.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();
      } else {
        filteredGroups = chatGroups;
      }
    });
  }

  void _openChatDetailScreen(ChatGroup chatGroup) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ChatDetailScreen(
              chatGroup: chatGroup,
            )));
  }

  @override
  Widget build(BuildContext context) {

    final chatGroups = ref.watch(chatGroupsProvider).chatGroups;
    
    filteredGroups = chatGroups;
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        // Set the preferred height for the app bar
        child: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Chat Groups',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          centerTitle: true, // Align the title to the left
          elevation: 0, // Remove the shadow
        ),
      ),
      body: Column(children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor, // Outside red color
          ),
          padding: EdgeInsets.all(10.0),
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .scaffoldBackgroundColor, // Square box white color
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey[600]),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search groups...',
                      border: InputBorder.none, // Use primary color
                    ),
                    onChanged: (value) {
                      searchQuery = value;
                      filterGroups(chatGroups);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredGroups.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  _openChatDetailScreen(filteredGroups[index]);
                },
                child: Column(
                  children: [
                    ChatGroupTile(filteredGroups[index]),
                    Padding(
                      padding: EdgeInsets.only(left: 62),
                      // Add padding to align divider
                      child: Divider(
                          height: 0,
                          color: Colors.grey[400],
                          thickness: 0.5), // Customized divider
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          // Handle New Group button pressed

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NewChatGroupScreen()));
        },
        child: Icon(Icons.group_add_sharp,color: Colors.white,),
          shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Adjust the position as needed
    );
  }
}
