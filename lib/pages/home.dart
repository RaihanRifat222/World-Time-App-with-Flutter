import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //By using late, you're telling the Dart compiler that although the variable is initially uninitialized, it will be assigned a value before it is used. This allows you to avoid using nullable types (Map<dynamic, dynamic>?) or initializing the variable with a default value.
  late Map<dynamic, dynamic> data ={};

  @override
  Widget build(BuildContext context) {
    //Recieve data from loading page
    data = data.isNotEmpty? data: ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>; // Add the type casting

    //set background
    String bgImage = data['isDaytime']? 'day.png' : 'night.png';
    Color bgColor = data['isDaytime']? Colors.indigo : Colors.blue;
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(

          //bring the button down
          padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                ElevatedButton.icon(
                    onPressed: () async{
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDaytime': result['isDaytime'],
                          'flag': result['flag']
                        };
                      });
                    },
                    icon: Icon(Icons.edit_location),
                    label: Text('Edit Location'),

                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget> [
                    Text(
                      data['location'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['time'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 58.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
