import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:krucial_systems/screens/home_screen.dart';
import 'package:page_transition/page_transition.dart';
class GettingStarted extends StatelessWidget {
  const GettingStarted({Key key}) : super(key: key);

  ///TODO: take permissions
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image(
              image: AssetImage('assets/images/pic.png'),
            ),
            Text('SAVE TIME',style: TextStyle(color: HexColor('#056d4a'),fontSize: 50,fontWeight: FontWeight.w900),),
            Container(
              width: MediaQuery.of(context).size.width*0.72,
              child: Column(
                children: [
                  Text('Shop from over 1,200 local stores at your',style: TextStyle(color:Colors.black,fontSize: 15,fontWeight: FontWeight.w600)),
                  Text('fingertips',style: TextStyle(color:Colors.black,fontSize: 15,fontWeight: FontWeight.w600)),
                ],
              )),
            GestureDetector(
              onTap: (){
                Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: HomeScreen(),duration: Duration(seconds: 1)));
              },
              child: Container(
                width: width*0.8,
                height: height*0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: HexColor('#056d4a'),
                ),
                child: Center(child: Text('Get Started',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w900))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
