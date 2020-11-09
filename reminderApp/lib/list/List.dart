import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:reminderApp/calenderPage/calenderScreen.dart';
import 'package:reminderApp/list/navigationDrawer.dart';
import 'package:reminderApp/model/model.dart';
import 'package:reminderApp/database/sqflite.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ReminderList extends StatefulWidget {
  @override
  _ReminderListState createState() => _ReminderListState();
}
class _ReminderListState extends State<ReminderList> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
   @override
  void initState() {
    super.initState();  
    isSwitched=false;
      loadDatabase();
      
  //    const AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('app_icon');
  //   final IOSInitializationSettings initializationSettingsIOS =
  //     IOSInitializationSettings(
  //         requestAlertPermission: false,
  //         requestBadgePermission: false,
  //         requestSoundPermission: false,
  //          );
  // // const MacOSInitializationSettings initializationSettingsMacOS =
  // //     MacOSInitializationSettings(
  // //         requestAlertPermission: false,
  // //         requestBadgePermission: false,
  // //         requestSoundPermission: false);
  // final InitializationSettings initializationSettings = InitializationSettings(
  //      initializationSettingsAndroid,
  //     initializationSettingsIOS,
  //     // macOS: initializationSettingsMacOS
  //     );
  
  //     flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onSelectNotification: notificationselected );
  }
    List<DataRow> _rowList = []; 
    List<Map> filtered=[];
    bool isSwitched;
    var _value=1;
  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    return Scaffold(
       backgroundColor: Color.fromRGBO(12, 26, 42, 1),
       appBar: AppBar(
          backgroundColor: Color.fromRGBO(12, 26, 42, 1),
          title:  Text('Reminders' ),
          centerTitle: true,
          actions: [
            IconButton(icon: Icon(Icons.delete,color:Colors.grey[600]), onPressed:(){ 
               setState(() {
                  _rowList.clear();
                  filtered.clear();
                  allAlram=[];
                });
              _deleteDataBase();
              }
          ) ],
      ), 
    drawer: NavDrawer(),
    body : SafeArea(
      child: SingleChildScrollView(
      padding:EdgeInsets.fromLTRB(0, 4, 6, 4),
      child:Column(
          children: [
                  SizedBox(height:2,width:MediaQuery.of(context).size.width, child: Container(color: Colors.black26 ),),
                  DataTable(
                          dataRowHeight: 130.0,
                          dividerThickness: 2.7,
                          columns: <DataColumn>[
                            DataColumn( label:Container(alignment: Alignment.centerRight,
  child:Row(
     mainAxisAlignment:MainAxisAlignment.end  ,
    children: [
      SizedBox(width:30),
      Text('Filter  ',style: TextStyle(color:Colors.white),textScaleFactor: 1.6,),
      SizedBox(width:90),
      DropdownButton(
              dropdownColor: Colors.indigo[900],
              iconEnabledColor:Colors.white ,
              value: _value,
              items: [
                DropdownMenuItem(
                  child: Text("All",style: TextStyle(color:Colors.white)),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("Once",style: TextStyle(color:Colors.white)),
                  value: 2,
                ),
                DropdownMenuItem(
                  child: Text("Dialy",style: TextStyle(color:Colors.white)),
                  value: 3
                ),
                DropdownMenuItem(
                    child: Text("Weekly",style: TextStyle(color:Colors.white)),
                    value: 4
                ), DropdownMenuItem(
                    child: Text("Monthly",style: TextStyle(color:Colors.white)),
                    value: 5
                )
              ],
              onChanged: (value) {
                print(value);
                switch (value) {
                  case 1:{
                      filtered.clear();
                    _showAllListdata(allAlram);
                  }
                    break;
                    case 2:{
                      filtered.clear();
                      for (var item in allAlram) { 
                        if(item['repeatId']==1)
                        filtered.add(item);
                      }
                        _showAllListdata(filtered);
                      }
                    break;
                    case 3:{
                      filtered.clear();
                      for (var item in allAlram) {
                         if(item['repeatId']==2)
                        filtered.add(item);
                      }
                        _showAllListdata(filtered);
                      } break;
                    case 4:{ 
                      filtered.clear();
                      for (var item in allAlram) {
                          if(item['repeatId']==3)
                          filtered.add(item);
                      }
                      _showAllListdata(filtered);
                    } break;
                    case 5:{
                      filtered.clear();
                      for (var item in allAlram) {
                         if(item['repeatId']==4)
                        filtered.add(item);  }
                        _showAllListdata(filtered);
                       } break;
                  default:
                  }
                    setState(() {
                      _value = value;
                    });
                  }
                ),],
                )
               )
              ),
             ],
             rows: _rowList,
           )  ]
        )
      )
    ),
   floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent[600],
        onPressed: () async {
          await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarScreen())
                );
                setState(()=>_value=1 );
                // _showNotification(allAlram);
              _showAllListdata(allAlram); 
              } ,
        tooltip: "add reminder",
        child: Icon(Icons.add ,color: Colors.white,),
                ),
          );
  }
    void _showAllListdata(var allAlram) {
          setState(() { 
              _rowList.clear();
          });
        if(allAlram.isNotEmpty){  
            setState(() {
              for (int index=0;index<allAlram.length;index++){
                _rowList.add(
               DataRow(cells: <DataCell>[
                  DataCell(  Container(
                  width: 260,
                  padding: EdgeInsetsDirectional.only(start :10,bottom: 2),
                  decoration:
                      index.isEven? BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.indigo[900],
                              Colors.blue[600],
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter
                          ),
                        borderRadius: BorderRadius.circular(22),)
                        : BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.pink[600],
                              Colors.orange[400],
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter
                          ),
                          borderRadius: BorderRadius.circular(22),
                        ),
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    // Row(children: [
                       Text(
                        allAlram[index]['time'],
                        style: TextStyle(
                            fontFamily: 'avenir',
                            color: CustomColors.primaryTextColor,
                            fontSize: 32),
                      ),
        //               Positioned(right: 7,
        //                 child:Switch(
                    //       value: isSwitched,
                    //       onChanged: (value){
                    //         setState(() {
                    //           isSwitched=value;
                    //           print(isSwitched);
                    //         });
                    //   },
                    //   activeTrackColor: Colors.lightGreenAccent,
                    //   activeColor: Colors.deepPurple[700],
        // ),
        //                 )
                      // ],
                      // ) ,
                    allAlram[index]['repeatId']==2?  Text(
                        'Every Day from :',
                        style: TextStyle(
                            letterSpacing: 1.1,
                            fontFamily: 'avenir',
                            fontWeight: FontWeight.w300,
                            color: CustomColors.primaryTextColor,
                            fontSize: 20),
                      ):Container(),
                      allAlram[index]['repeatId']==3? Text(
                       'Every  "${allAlram[index]['weekday']}"   from :',
                        style: TextStyle(
                            letterSpacing: 1.1,
                            fontFamily: 'avenir',
                            fontWeight: FontWeight.w300,
                            color: CustomColors.primaryTextColor,
                            fontSize: 20),
                      ):Container(),
                    
                      Text( allAlram[index]['date'],
                         textAlign: TextAlign.left,        
                         style: TextStyle(
                            fontFamily: 'avenir',
                            fontWeight: FontWeight.w300,
                            color: CustomColors.primaryTextColor,
                            fontSize: 20),
                      ),
                   Text(allAlram[index]['description'],
                        style: TextStyle(
                            fontFamily: 'avenir',
                            fontWeight: FontWeight.w300,
                            color: CustomColors.primaryTextColor,
                            fontSize: 16),
                      ),
                    ],
                  ),
                )
              ),  
             ]
            )
          );   
        }
      }
     );
      }else print('no allAlrams in list');
  }
    loadDatabase() async {
     await DBProvider.db.getAlldata();
    // wait for 1 second to simulate loading of data
    await Future.delayed(const Duration(seconds: 1));
    _showAllListdata(allAlram);
  }
  _deleteDataBase() async {
    await DBProvider.db.deleteAllEmployees();
    // wait for 1 second to simulate loading of data
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
    });
    print('All alram deleted');
  }

//    Future<dynamic>  notificationselected( String paload) async{
// showDialog(context:context,
// builder: (context)=>AlertDialog(
//   content: Text('done'),
// ));
//    }
   
//   int once=0 ,daily=0,weekly=0;
//   Future _showNotification(List<Map>allAlram ) async{
    
//     var androidnoti =new AndroidNotificationDetails('channel Id','desi programer','this notification',
//     importance: Importance.Max );
//       var ios= new IOSNotificationDetails() ;
//    NotificationDetails platformChannelSpecifics =  NotificationDetails(androidnoti,ios);
// if(allAlram.length<2){
//     for (var item in allAlram){
//     if(item['repeatId']==1)once=once+1;
//     if(item['repeatId']==2)daily=daily+1;
//     if(item['repeatId']==3)weekly=weekly+1;
    
//     }

// }
//     for (var item in allAlram) {
//       print('toDate set notification : ${(item['toDate'])}');
//             switch (item['repeatId']) {
//         case 1:{if(once<2)
//              flutterLocalNotificationsPlugin.schedule(item['id'], 'flutter reminder',
//         item['description'].toString(),DateTime.parse( item['toDate']), platformChannelSpecifics, );
    
//         }
          
//           break;
//            case 2:{
//            var datetime=  DateTime.parse( item['toDate']);
//              var time= Time(datetime.hour,datetime.minute,datetime.weekday);
//              print('time $time');
//              if(daily<2)
//               flutterLocalNotificationsPlugin.showDailyAtTime(
//                 item['id'], 'flutter reminder', item['description'].toString(),time, platformChannelSpecifics);
//             }
          
//           break;
//            case 3:{
//               var datetime=  DateTime.parse( item['toDate']);
//               print(datetime.weekday);
              
//              var time= Time(datetime.hour,datetime.minute,datetime.weekday);
//               if(weekly<2)
//                flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
//                    item['id'], 'flutter reminder', item['description'].toString(), Day(datetime.weekday), time, platformChannelSpecifics);
//            }
          
//           break;
          
//         default:
//       }
//     }
  
//   }

}