import 'package:flutter/material.dart';
import 'package:reminderApp/firebase/localNoootification.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  curve: Curves.easeOutQuart,
                  padding: EdgeInsets.fromLTRB(3, 3, 3, 3) ,
                margin:  EdgeInsets.only(bottom: 3.0),    // padding = const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
        child: Text('\n\n       Reminder Application',style: TextStyle(color:Colors.white ), textScaleFactor: 1.6,),
        decoration: BoxDecoration(
          color: Color.fromRGBO(12, 41, 96, 1),
        ),
      ),
ListTile(
  focusColor: Colors.grey[300],
  title:Text('Demo of Reminder',textScaleFactor: 1.2),
  trailing: Icon(Icons.arrow_forward),
  onTap:(){
     Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocalNotification())
              );
  }
)
       ]
       )
    
  
    );
  }
}