import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_project/utils/colors.dart';

class notifications extends StatefulWidget {
  const notifications({Key? key}) : super(key: key);

  @override
  _notifications createState() => _notifications();
}

class _notifications extends State<notifications> {
  final List<String> myNotifications = ['Bobby liked your post.', 'Fluffy send you a friend request.', 'Daisy commented: Great!', 'Princess liked your post.'];
  void buttonPressed(int index, List myList) {
    print('deleted');
    setState(() {
      myList.removeAt(index);
    });
  }
  @override
  void initState(){
    super.initState();
    print('initState');
  }
  Widget build(BuildContext context){
    const title = 'Notifications';
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
              itemCount: myNotifications.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 24, 20, 0),
                  child: SizedBox(
                    height: 100, width: 50,
                    child: ListTile(
                      title: Text(myNotifications[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
                      trailing: SizedBox(
                        height: 100, width: 144,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            deleteButton(index, myNotifications),
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

  Widget deleteButton(int index, List myList){
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
            child: Text('Delete', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white,),),
            onPressed: () {
              buttonPressed(index, myList);
            }
        ),
      ),
    );
  }
}