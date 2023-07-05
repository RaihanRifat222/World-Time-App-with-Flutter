import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png' ),
    WorldTime(url: 'Europe/Berlin', location: 'Berlin', flag: 'germany.png' ),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png' ),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png' ),
    WorldTime(url: 'Asia/Dhaka', location: 'Dhaka', flag: 'bd.png' ),
    WorldTime(url: 'Asia/Dubai', location: 'Dubai', flag: 'uae.png' ),
  ];
  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();

    //navigate to home screen
    Navigator.pop(context,{
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });
  }
  @override
  Widget build(BuildContext context) {
    // print('build function ran');
    return Scaffold(

      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        title: Text('Choose a location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 5.0),
            child: Card(
              child: ListTile(
                onTap: (){
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),
      // body: ElevatedButton.icon(
      //   onPressed: (){
      //     setState(() {
      //       counter++;
      //     });
      //   },
      //   label: Text('Counter is $counter'),
      //   icon: Icon(Icons.add),
      //
      // ),

    );
  }
}
