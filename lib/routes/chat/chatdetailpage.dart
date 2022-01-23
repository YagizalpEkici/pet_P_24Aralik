import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pet_project/routes/chat/chatdetailpageappbar.dart';
import 'package:pet_project/routes/chat/chatbubble.dart';
import 'package:pet_project/routes/chat/chatmessage.dart';
import 'package:pet_project/routes/chat/chatsendmenuitems.dart';

enum MessageType{
  Sender,
  Receiver,
}

class ChatDetailPage extends StatefulWidget {
  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<ChatMessage> chatMessage = [
    ChatMessage(message: "Hey! How's it going?", type: MessageType.Receiver),
    ChatMessage(message: "For the record, we're going to have dinner at KEV with Bengi. Wanna join?", type: MessageType.Receiver),
    ChatMessage(message: "Sure, I'll come.", type: MessageType.Sender),
    ChatMessage(message: "Never mind, plans have changed...", type: MessageType.Receiver),
    ChatMessage(message: "Wanna play F1 video game at 10pm!", type: MessageType.Receiver),
  ];

  List<ChatSendMenuItems> menuItems = [
    ChatSendMenuItems(text: "Photos & Videos", icons: Icons.image, color: Colors.amber),
    ChatSendMenuItems(text: "Document", icons: Icons.insert_drive_file, color: Colors.blue),
    ChatSendMenuItems(text: "Audio", icons: Icons.music_note, color: Colors.orange),
    ChatSendMenuItems(text: "Location", icons: Icons.location_on, color: Colors.green),
    ChatSendMenuItems(text: "Contact", icons: Icons.person, color: Colors.purple),
  ];

  void showModal(){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            child: Column(
              children: [
                SizedBox(height: 16,),
                Center(
                  child: Container(
                    height: 4,
                    width: 50,
                    color: Colors.grey.shade200,

                  ),
                ),
                SizedBox(height: 16,),
                ListView.builder(
                  itemCount: menuItems.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: menuItems[index].color.shade100,
                          ),
                          height: 50,
                          width: 50,
                          child: Icon(menuItems[index].icons, size: 20, color: menuItems[index].color.shade400,),
                        ),
                        title: Text(menuItems[index].text),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatDetailPageAppBar(),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: chatMessage.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ChatBubble(
                  chatMessage: chatMessage[index],
                );
              }
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 16, bottom: 10),
              height: 70,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      showModal();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 21,),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Type message...",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.only(right: 15, bottom: 15),
              child: FloatingActionButton(
                onPressed: (){
                },
                child: Icon(Icons.send, color: Colors.white,),
                backgroundColor: Colors.orange,
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
