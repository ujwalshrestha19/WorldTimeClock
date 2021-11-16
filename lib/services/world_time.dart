import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
 String location = ''; //location name for UI
 String time = ''; // time in that location
 String flag= ''; //URL to asset flag icon
 String url= ''; //location url for API end points
 bool isDaytime = false;

  WorldTime({required this.location,  required this.flag, required this.url});

  Future <void> getTime() async {
    try {
      Response response = await get(
          Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'];
      String offset1 = data['utc_offset'].substring(1, 3);
      String offset2 = data['utc_offset'].substring(4, 6);

      // print(dateTime);
      // print(offset);

      //create DateTime Object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(
          Duration(hours: int.parse(offset1), minutes: int.parse(offset2)));
      //print(now);
      isDaytime= now.hour >6 && now.hour<15?true:false;
      //set time Property
      time = DateFormat.jm().format(now);
    } catch (e) {
      //print('caught error: $e');
      time= 'could not get time data';
    }
  }
}

