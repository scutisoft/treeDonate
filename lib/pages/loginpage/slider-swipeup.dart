import 'package:flutter/material.dart';
import '../../helper/language.dart';
import '../../pages/volunteer/addvolunteer.dart';
import '../../widgets/fittedText.dart';
import '../../helper/appVersionController.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../donateTree/donateTree.dart';
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
  void initState(){
    AppVersionController().checkVersion();
    super.initState();
  }


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
                child: Image.asset('assets/Slice/logoin-bg.jpg',fit:BoxFit.cover)
                // CarouselSlider(
                //   options: CarouselOptions(
                //     height: SizeConfig.screenHeight,
                //     viewportFraction: 1.0,
                //     enlargeCenterPage: false,
                //      scrollDirection: Axis.vertical,
                //     autoPlay: true,
                //   ),
                //   items: imgList
                //       .map((item) => Container(
                //     child: Center(
                //         child: Image.asset(
                //           item,
                //           fit: BoxFit.cover,
                //           height: SizeConfig.screenHeight,
                //         )),
                //   ))
                //       .toList(),
                // )
            ),
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
                    const SizedBox(width: 15,),
                    Text(Language.growingPlant['Value'],style: TextStyle(color: ColorUtil.themeWhite,fontFamily: Language.growingPlant['FontFamily'],fontSize: Language.growingPlant['FontSize'],),),
                    const SizedBox(width: 10,),
                    const Icon(Icons.arrow_downward_outlined,color: ColorUtil.menu,size: 25,)
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
                        Text(Language.takeLogin['Value'],style: TextStyle(color: ColorUtil.themeWhite,fontFamily: Language.takeLogin['FontFamily'],fontSize: Language.takeLogin['FontSize'],),),
                        const SizedBox(width: 10,),
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
                  padding: const EdgeInsets.only(left: 5,right: 5 ),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  //child: FittedBox(child: Text("+ ${Language.volunteer}",style: ts18(ColorUtil.themeBlack,fontsize: 16),)),
                  child: FittedText(
                    textStyle: ts18(ColorUtil.themeBlack,fontsize: Language.volunteer['FontSize'],fontfamily: Language.volunteer['FontFamily']),
                    text: "+ ${Language.volunteer['Value']}",
                    height: 25,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10,
              bottom: 160,
              child: GestureDetector(
                onTap: (){
                  fadeRoute(DonateTreePage(
                    voidCallback: (){},
                    isDirectDonate: true,
                  ));
                },
                child: Container(
                  height: 50,
                 width: 120,
                 alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 5,right: 5 ),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  //child: FittedBox(child: Text("+ ${Language.volunteer}",style: ts18(ColorUtil.themeBlack,fontsize: 16),)),
                  child: FittedText(
                    textStyle: ts18(ColorUtil.themeBlack,fontsize: 20,fontfamily: 'Reg'),
                    text: Language.donate,
                    height: 25,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



