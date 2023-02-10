import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/pages/volunteer/addvolunteer.dart';

import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import 'login.dart';

class SlideSwipe extends StatefulWidget {
  const SlideSwipe({Key? key}) : super(key: key);

  @override
  _SlideSwipeState createState() => _SlideSwipeState();
}
class _SlideSwipeState extends State<SlideSwipe> {
  final List<String> imgList = [
    'assets/Slice/logoin-bg.jpg',
    'assets/Slice/logoin-bg.jpg',
    'assets/Slice/logoin-bg.jpg',
    'assets/Slice/logoin-bg.jpg',
  ];




 @override
  Widget build(BuildContext context) {

    return SafeArea(
      bottom: MyConstants.bottomSafeArea,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: SizeConfig.screenHeight,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                     scrollDirection: Axis.vertical,
                    autoPlay: true,
                  ),
                  items: imgList
                      .map((item) => Container(
                    child: Center(
                        child: Image.asset(
                          item,
                          fit: BoxFit.cover,
                          height: SizeConfig.screenHeight,
                        )),
                  ))
                      .toList(),
                )),
            Align(
                alignment: Alignment.topCenter,
                child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/logo.png',width: 250,),
                )
            ),
            Positioned(
                bottom: 40,
                left: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:EdgeInsets.all(2),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                       border:Border.all(color: ColorUtil.menu),
                        borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Image.asset('assets/login/leaf.png',width: 50,),
                    ),
                    SizedBox(width: 15,),
                    Text('Growing \nPlant',style: TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RB',fontSize: 15,),),
                    SizedBox(width: 10,),
                    Icon(Icons.arrow_downward_outlined,color: ColorUtil.menu,size: 25,)
                  ],
                )
            ),
            Positioned(
              bottom: 200,
                right: 0,
                child: GestureDetector(
                  onTap: (){
                    fadeRoute(loginPage());
                  },
                  child: Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      color: ColorUtil.primary,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft:Radius.circular(10) ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Take \nLogin',style: TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RR',fontSize: 15,),),
                        SizedBox(width: 10,),
                        Icon(Icons.arrow_forward_ios,color: ColorUtil.themeWhite,size: 20,)
                      ],
                    ),
                  ),
                )
            ),
            Positioned(
              left: 10,
              bottom: 100,
              child: GestureDetector(
                onTap: (){
                  fadeRoute(AddVolunteer(
                    isDirectAdd: true,
                  ));
                },
                child: Container(
                  height: 50,
                 width: 120,
                 alignment: Alignment.center,
                 // padding: EdgeInsets.only(left: 10,right: 10,top: ),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text("+ Volunteer",style: ts18(ColorUtil.themeBlack),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



