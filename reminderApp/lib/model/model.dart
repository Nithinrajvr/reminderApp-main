
import 'dart:convert';
import 'package:flutter/material.dart';

// var selected ='' ;
List<Map> allAlram=[];
class CustomColors {
  static Color primaryTextColor = Colors.white;
  static Color dividerColor = Colors.white54;
  static Color pageBackgroundColor = Color(0xFF2D2F41);
  static Color menuBackgroundColor = Color(0xFF242634);

  static Color clockBG = Color(0xFF444974);
  static Color clockOutline = Color(0xFFEAECFF);
  static Color secHandColor = Colors.orange[300];
  static Color minHandStatColor = Color(0xFF748EF6);
  static Color minHandEndColor = Color(0xFF77DDFF);
  static Color hourHandStatColor = Color(0xFFC279FB);
  static Color hourHandEndColor = Color(0xFFEA74AB);
}

class GradientColors {
   List<Color> colors;
  GradientColors(this.colors);

  static List<Color> sky = [Color(0xFF6448FE), Color(0xFF5FC6FF)];
  static List<Color> sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];
  static List<Color> sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];
  static List<Color> mango = [Color(0xFFFFA738), Color(0xFFFFE130)];
  static List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];
}

class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
  ];
}


// To parse this JSON data, do
//
//      ReminderClass = ReminderClassFromJson(jsonString);


ReminderClass reminderClassFromJson(String str) => ReminderClass.fromJson(json.decode(str));

String reminderClassToJson(ReminderClass data) => json.encode(data.toJson());

class ReminderClass {
    ReminderClass({
        this.date='',
        this.time='',
        this.fromDate='',
        this.toDate='',
        this.description='',
        this.weekday='',
        this.repeatId=1,
    });

     String date;
     String time;
     String fromDate;
     String toDate;
     String description;
     String weekday;
     int repeatId;

    factory ReminderClass.fromJson(Map<String, dynamic> json) => ReminderClass(
        date: json["date"] == null ? null : json["date"],
        time: json["time"] == null ? null : json["time"],
        fromDate: json["fromDate"] == null ? null : json["fromDate"],
        toDate: json["toDate"] == null ? null : json["toDate"],
        description: json["description"] == null ? null : json["description"],
        weekday: json["weekday"] == null ? null : json["weekday"],
        repeatId: json["repeatId"] == null ? null : json["repeatId"],
    );

    Map<String, dynamic> toJson() => {
        "date": date == null ? null : date,
        "time": time == null ? null : time,
        "fromDate": fromDate == null ? null : fromDate,
        "toDate": toDate == null ? null : toDate,
        "description": description == null ? null : description,
        "weekday": weekday == null ? null : weekday,
        "repeatId": repeatId == null ? null : repeatId,
    };
}


    List<Map> minute=[
  {
    'id': 0,
    'value' :'0'
  },{
    'id': 1,
    'value' :'1'
  },{
    'id': 2,
    'value' :'2'
  },{
    'id': 3,
    'value' :'3'
  },{
    'id': 4,
    'value' :'4'
  },
  {
    'id': 5,
    'value' :'5'
  },
  {
    'id': 6,
    'value' :'6'
  }
  ];
    List<Map> second=[
       {
    'id': 0,
    'value' :'00'
  },
  {
    'id': 1,
    'value' :'10'
  },{
    'id': 2,
    'value' :'20'
  },{
    'id': 3,
    'value' :'30'
  },{
    'id': 4,
    'value' :'40'
  },
  {
    'id': 5,
    'value' :'50'
  },
  {
    'id': 6,
    'value' :'60'
  }
  ];