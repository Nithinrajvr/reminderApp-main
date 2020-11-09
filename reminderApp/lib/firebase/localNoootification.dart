import 'package:flutter/material.dart';
import 'package:reminderApp/model/model.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification extends StatefulWidget {
  @override
  _LocalNotificationState createState() => _LocalNotificationState();
}

class _LocalNotificationState extends State<LocalNotification> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
   bool _autoValidate= false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var sizebox=SizedBox(height:4);
   NotificationAppLaunchDetails notification ;
   bool circularIndi,_isButtonDisabled;
 @override
  void initState() {
    super.initState();  
    circularIndi=_isButtonDisabled=false;
    
     const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
           );
  // const MacOSInitializationSettings initializationSettingsMacOS =
  //     MacOSInitializationSettings(
  //         requestAlertPermission: false,
  //         requestBadgePermission: false,
  //         requestSoundPermission: false);
  final InitializationSettings initializationSettings = InitializationSettings(
       initializationSettingsAndroid,
      initializationSettingsIOS,
      // macOS: initializationSettingsMacOS
      );
  
      flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: notificationselected );
  }
 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.indigo[100],
      appBar:  AppBar(
        backgroundColor: Colors.indigo[900],
        actions:[ 
           Center(child:Text(' |  ',textScaleFactor: 1.8,),),
        ]
    
      ),
      key:_scaffoldKey ,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
               decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.indigo[600],
                Colors.indigo[100],
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            ),
          ),
            padding:  EdgeInsets.all(15.0),
            child: new Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child:widgets() ),
            )
     
      )
  ),
  
 );
}
      Widget widgets(){
        return Column(
          children: <Widget>[
             
             sizebox,
            sizebox,
            minutewidget(),
            sizebox,
            _secondwidget(),
            sizebox,
            _description(),
            sizebox,
            circularIndi==true?CircularProgressIndicator():Container(),
            RaisedButton(
              color: Colors.indigo[900],
      child: new Text(
        _isButtonDisabled ? "Hold on..." : "Test Notification",style: TextStyle(color:Colors.white),
      ),
      onPressed: _isButtonDisabled ? null : _validateInputs,
    )
           
          ],
        );
  }
  var description='';
    Widget _description() { 
      return TextFormField(
         textAlign: TextAlign.start,
        maxLines: 3,
        // controller: descriptionctr,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(3, 4, 60, 4),
            labelText: 'Description',
             labelStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),
           fillColor: Colors.white,),
          textInputAction: TextInputAction.done,
          // validator: re,
                   onSaved: (val) =>description=val
      
        );
}



  var minuteval;
  Widget minutewidget() { 
      return DropdownButtonFormField<String>(
            decoration: InputDecoration( hintText: 'Repeat',
               labelStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),
            labelText: "Minute"
            ),
            value:minuteval,//  findval(examinarapiId,5), //
            onChanged: (String newValue) => minuteval= minuteval,
            validator: (value) => value == null ? 'field required' : null,
             onSaved: (val) =>minuteval=val,//  saveUserData.nationality=val,
            items: minute.map((item) {
              return new DropdownMenuItem(
                child: new Text(item['value']),
                value: item['value'].toString(),
                onTap: () {
                
                  // minuteval = item['id'];
             //     print(examinarapiId);
                },
              );
            }).toList(),
         
      );
} var sec,secondval;
  Widget _secondwidget() { 
      return DropdownButtonFormField<String>(
            decoration: InputDecoration( hintText: 'Repeat',
               labelStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),
            labelText: "Second"
            ),
            value:secondval,//  findval(examinarapiId,5), //
            onChanged: (String newValue) => secondval= secondval,
            validator: (value) => value == null ? 'field required' : null,
             onSaved: (val) =>secondval=val,//  saveUserData.nationality=val,
            items: second.map((item) {
              return new DropdownMenuItem(
                child: new Text(item['value']),
                value: item['value'].toString(),
                onTap: () {
                
                  // repeatId = item['id'];
             //     print(examinarapiId);
                },
              );
            }).toList(),
         
      );
}
 void _validateInputs() {
  if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
    _formKey.currentState.save();
    _showNotification(minuteval,secondval,description);
    print('$minuteval,$secondval,$description');
setState(() {
      circularIndi = true;
      _isButtonDisabled=true;
      
    });
    
  Future.delayed(Duration(minutes: int.parse(minuteval) ,seconds: int.parse(secondval))).then((value){
    setState(() {
      circularIndi = false;
      _isButtonDisabled=false;
      
    });
  });
 
  } else {
//    If all data are not valid then start auto validation.
    setState(() {
      _autoValidate = true;
    });
  }
}
  
   Future<dynamic>  notificationselected( String paload) async{
showDialog(context:context,
builder: (context)=>AlertDialog(
  content: Text('done'),
));
   }
  Future _showNotification(String minute ,String sec,String body) async{
    print('$minute : $sec');
    var androidnoti =new AndroidNotificationDetails('channel Id','desi programer','this notification',
    importance: Importance.Max );
      var ios= new IOSNotificationDetails() ;
   NotificationDetails platformChannelSpecifics =  NotificationDetails(androidnoti,ios);
// await flutterLocalNotificationsPlugin.show(0, 'task', 'task', platformChannelSpecifics);
    var sheduleNotification= DateTime.now().add(Duration(minutes:int.parse(minute) ,seconds: int.parse(sec)));
     var sheduleNotificationSecond= DateTime.now().add(Duration(seconds:6));
    // for (var item in allAlram) {
      // print(DateTime.parse( item['toDate']));
        flutterLocalNotificationsPlugin.schedule(234, 'flutter reminder',
         'body',sheduleNotification, platformChannelSpecifics, );
      //  flutterLocalNotificationsPlugin.showDailyAtTime(id, title, body, notificationTime, notificationDetails)
      //  flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(id, title, body, day, notificationTime, notificationDetails)
      //  flutterLocalNotificationsPlugin.periodicallyShow(id, title, body, repeatInterval, notificationDetails)
      // flutterLocalNotificationsPlugin.cancelAll()
    // }
    
   // flutterLocalNotificationsPlugin.schedule  (0, 'flutter reminder', body, sheduleNotification, platformChannelSpecifics, );
   }

}
