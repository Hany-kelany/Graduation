import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:gradproject/screens/record_and_play_audio.dart';
import 'package:vibration/vibration.dart';

class AlertScreen extends StatelessWidget {
  const AlertScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alerting Methods',
          style: TextStyle(fontSize: 22),
        ),
        backgroundColor: Color(0xff386c9c),
        elevation: 0,
      ),
      body: Container(
        //padding: EdgeInsets.symmetric(horizontal: 3),
        color: Color(0xff032b50), width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
               width: double.infinity,
              color: Color(0xff989898),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28.0, vertical: 25),
                child: Text(
                  'Please select how you want to be notified',
                  style: TextStyle(
                    color: Color(0xff032b50),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Vibration.vibrate(
                  duration: 1000,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 20),
                    child: Text('Vibration',
                      style: TextStyle(color: Colors.white,fontSize: 25),),
                  ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.vibration),
                        SizedBox(width: 8,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('You will be notified through a vibration ',style: TextStyle(color: Colors.blueGrey[200],fontSize: 20),),
                            Text(' pattern from your mobile',style: TextStyle(color: Colors.blueGrey[200],fontSize: 20),)


                          ],
                        ),
                        //SizedBox(height: 20,)
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: 30,color: Colors.white,thickness: 1,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 10),
                    child: Text('FlashLight',
                      style: TextStyle(color: Colors.white,fontSize: 25),),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Icon(Icons.flashlight_on_outlined),
                      SizedBox(width: 8,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('You will be notified through your  ',style: TextStyle(color: Colors.blueGrey[200],fontSize: 20),),
                          Text(' mobile flashlight',style: TextStyle(color: Colors.blueGrey[200],fontSize: 20),),



                        ],
                      ),
                      //SizedBox(height: 20,)
                    ],
                  ),
                  Divider(height: 30,color: Colors.white,thickness: 1,)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 10),
                    child: Text('Smart Watch ',
                      style: TextStyle(color: Colors.white,fontSize: 25),),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Icon(Icons.watch),
                      SizedBox(width: 8,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('You will be notified through your ',style: TextStyle(color: Colors.blueGrey[200],fontSize: 20),),
                          Text(' smart watch',style: TextStyle(color: Colors.blueGrey[200],fontSize: 20),)


                        ],
                      ),
                      //SizedBox(height: 20,)
                    ],
                  ),
                ],
              ),
            ),
            Divider(height: 30,color: Colors.white,thickness: 1,),
            SizedBox(height: 20,),
            Center(
              child: AnimatedButton(
                height: 50,
                width: 200,
                text: 'SUBMIT',
                isReverse: true,
                selectedTextColor: Colors.black,
                transitionType: TransitionType.LEFT_TO_RIGHT,
                //textStyle: submitTextStyle,
                backgroundColor: Colors.grey,
                borderColor: Colors.white,
                borderRadius: 0,
                borderWidth: 1, onPress: () { Navigator.push(context, MaterialPageRoute(builder: (context) => RecordAndPlayScreen(),)); },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

