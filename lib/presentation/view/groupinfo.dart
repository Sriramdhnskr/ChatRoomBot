import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatroom_chatbot/presentation/view/editgroupscreen.dart';
import 'package:flutter/material.dart';

import '../../data/model/chatgroup.dart';
import '../../data/model/userprofile.dart';

List<UserProfile> sampleProfiles = [
  UserProfile(
    profileImageURL: "https://randomuser.me/api/portraits/men/1.jpg",
    name: "John Doe",
  ),
  UserProfile(
    profileImageURL: "https://randomuser.me/api/portraits/men/2.jpg",
    name: "Jane Smith",
  ),
  UserProfile(
    profileImageURL: "https://randomuser.me/api/portraits/men/3.jpg",
    name: "Michael Johnson",
  ),
  UserProfile(
    profileImageURL: "https://randomuser.me/api/portraits/men/4.jpg",
    name: "Sandy",
  ),
  UserProfile(
    profileImageURL: "https://randomuser.me/api/portraits/men/5.jpg",
    name: "Joseph",
  ),
  UserProfile(
    profileImageURL: "https://randomuser.me/api/portraits/men/6.jpg",
    name: "Arya",
  ),
  UserProfile(
    profileImageURL: "https://randomuser.me/api/portraits/men/7.jpg",
    name: "Michael Tyson",
  ),
];

class GroupInfoScreen extends StatefulWidget {
  final ChatGroup chatGroup;

  const GroupInfoScreen({required this.chatGroup});

  @override
  State<GroupInfoScreen> createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends State<GroupInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Theme.of(context)
                .primaryColor, // Background color of the custom app bar
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    // Handle back button press
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.chatGroup.image,
                      placeholder: (context, url) => CircleAvatar(
                        backgroundColor: Colors.grey, // Placeholder color
                        child: Icon(Icons.person), // Placeholder icon
                        radius: 40,
                      ),
                      errorWidget: (context, url, error) => CircleAvatar(
                        backgroundColor: Colors.grey, // Placeholder color
                        child: Icon(Icons.person), // Placeholder icon
                        radius: 40,
                      ), // Error widget
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: imageProvider,
                        radius: 40,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.chatGroup.name,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '100 Members',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    // Handle edit button press

                   /* void _editGroup() async {
                      // Navigate to the edit screen and await the result
                      final updatedChatGroup = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditChatGroupScreen(chatGroup: widget.chatGroup),
                        ),
                      );

                      // Update the chat group using the updatedChatGroup data
                      if (updatedChatGroup != null) {
                        setState(() {
                          widget.chatGroup = updatedChatGroup;
                        });
                      }
                    }*/

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditChatGroupScreen(
                              chatGroup: widget.chatGroup,
                            )));
                  },
                ),
              ],
            ),
          ),
          /*   Container(
            color: Colors.grey[300],
            width: double.infinity,
            height: 4,
          ),*/
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_add_rounded,
                  color: Colors.blue,
                ),
                // Add members icon
                SizedBox(width: 10),
                Text(
                  "Add members",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            width: double.infinity,
            height: 4,
          ),
          Material(
            elevation: 4,
            color: Colors.white, // Elevation for the tab effect
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(8),
              child: Center(
                child: Text(
                  "Members",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700]),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.grey[300],
            width: double.infinity,
            height: 2,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: sampleProfiles.length,
              // Replace with the actual number of members
              itemBuilder: (context, index) {
                UserProfile profile = sampleProfiles[index];
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            imageUrl: profile.profileImageURL,
                            placeholder: (context, url) => CircleAvatar(
                              backgroundColor: Colors.grey,
                              // Placeholder color
                              child: Icon(Icons.person),
                              // Placeholder icon
                              radius: 20,
                            ),
                            errorWidget: (context, url, error) => CircleAvatar(
                              backgroundColor: Colors.grey,
                              // Placeholder color
                              child: Icon(Icons.person),
                              // Placeholder icon
                              radius: 20,
                            ), // Error widget
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              backgroundImage: imageProvider,
                              radius: 20,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(profile.name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(height: 4),
                                Text(
                                  "online",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          // Spacer(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 62),
                      // Add padding to align divider
                      child: Divider(
                          height: 0,
                          color: Colors.grey[400],
                          thickness: 0.5), // Customized divider
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
