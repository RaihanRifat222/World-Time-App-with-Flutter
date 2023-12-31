import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location = ''; //for the UI
  String time  = ''; //time in that location
  String flag =''; //url to assert a flag icon
  String url =''; //location url for api endpoint
  bool isDaytime = true;
  WorldTime({this.location='', this.flag='', this.url=''});
  Future <void> getTime() async{

    await Future.delayed(Duration(seconds: 1), () {});


    try{
      Response response=await get(Uri.parse('https://www.worldtimeapi.org/api/timezone/$url'));

      Map data =jsonDecode(response.body);
      // print(data);
      String datetime = data['utc_datetime'];
      String offset = data['utc_offset'].substring(1,3);
      // print(datetime);
      // print(offset);

      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset) ));
      // print(now);
      isDaytime = now.hour>6 && now.hour <18  ? true : false;


      //set the time property
      time = DateFormat.jm().format(now);

    }
    catch(e){
      print(e);
      time = 'could not get data';
    }

  }



}

