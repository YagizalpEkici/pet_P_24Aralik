import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_project/utils/colors.dart';

class friendshipRequests extends StatefulWidget {
  const friendshipRequests({Key? key}) : super(key: key);

  @override
  _friendshipRequestsState createState() => _friendshipRequestsState();
}

class _friendshipRequestsState extends State<friendshipRequests> {
  int friendNum= 0;
  final List<String> friendRequestList = ['Bobby', 'Fluffy', 'Daisy', 'Rex', 'Suzzie', 'Princess', 'Snowball', 'T-rex'];
  final List<String> deniedRequests = [];
  final List<String> acceptedRequests = [];
  void buttonPressed(bool status, int index) {
    if(status == true){
      print('Accepted.');
    }
    else{
      print('Denied.');
    }
    setState(() {
      if(status == true){
        acceptedRequests.add(friendRequestList.elementAt(index));
        friendRequestList.removeAt(index);
        friendNum++;
      }
      else{
        deniedRequests.add(friendRequestList.elementAt(index));
        friendRequestList.removeAt(index);
      }
    });
  }
  @override
  void initState(){
    super.initState();
    print('initState');
  }
  Widget build(BuildContext context){
    const title = 'My Friend Requests';
    return MaterialApp(
        title: title,
        home: Scaffold(
          appBar: AppBar(
            title: const Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
            leading: IconButton(icon: Icon(Icons.arrow_back),
              onPressed: ()=>Navigator.pop(context, false),),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: friendRequestList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 24, 20, 0),
                  child: SizedBox(
                    height: 100, width: 50,
                    child: ListTile(
                      //add profile pictures
                      title: Text(friendRequestList[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
                      trailing: SizedBox(
                        height: 100, width: 144,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            acceptButton(index),
                            denyButton(index),

                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        )
    );
  }
  Widget acceptButton(int index){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Theme
                          .of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5);
                    return Colors.green;
                  }
              ),
            ),
            child: Text('✔', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white,),),
            onPressed: () {
              buttonPressed(true, index);
            }
        ),
      ),
    );
  }
  Widget denyButton(int index){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Theme
                          .of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5);
                    return Colors.red;
                  }
              ),
            ),
            child: Text('X', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white,),),
            onPressed: () {
              buttonPressed(false, index);
            }
        ),
      ),
    );
  }
/*Widget totalFriendContainer(){
    return Container(
      margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: AppColors.Background,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.app_icons,)]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Total Friends: ', style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.text_color,
              ),
              ),
              Text(friendNum.toString(), style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.text_color,
              ),
              ),
            ],
          ),
        ],
      ),
    );
  }*/
}