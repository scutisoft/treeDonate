import 'package:flutter/material.dart';
import '../../helper/language.dart';
import '../../pages/volunteer/addvolunteer.dart';
import '../../widgets/fittedText.dart';
import '../../helper/appVersionController.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/glow.dart';
import '../../widgets/shakeAnim/src/shake_horizontal_constant.dart';
import '../../widgets/shakeAnim/src/shake_widget.dart';
import '../donateTree/donateTree.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
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
            /*Positioned(
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
            ),*/
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
                        Text(Language.takeLogin['Value'],
                          style: TextStyle(color: ColorUtil.themeWhite,fontFamily: Language.takeLogin['FontFamily'],
                            fontSize: 15,),),
                        const SizedBox(width: 10,),
                        Icon(Icons.arrow_forward_ios,color: ColorUtil.themeWhite,size: 20,)
                      ],
                    ),
                  ),
                )
            ),

            Positioned(
              bottom: 50,
              child: Container(
                width: SizeConfig.screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
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
                            color: ColorUtil.primary,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        //child: FittedBox(child: Text("+ ${Language.volunteer}",style: ts18(ColorUtil.themeBlack,fontsize: 16),)),
                        child: FittedText(
                          textStyle: ts18(ColorUtil.themeWhite,fontsize: 15,fontfamily: 'Reg'),
                          text: "+ ${Language.volunteer['Value']}",
                          height: 22,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40,),

                    ShakeWidget(
                      duration: const Duration(seconds: 5),
                      shakeConstant: ShakeHorizontalConstant1(),
                      autoPlay: true,
                      enableWebMouseHover: false,
                      child: GestureDetector(
                        onTap: (){
                          //sw();
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
                              color: const Color(0xffB9EB4E),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          //child: FittedBox(child: Text("+ ${Language.volunteer}",style: ts18(ColorUtil.themeBlack,fontsize: 16),)),
                          child: FittedText(
                            textStyle: ts18(ColorUtil.themeBlack,fontsize: 15,fontfamily: 'Reg'),
                            text:  "${MyConstants.rupeeString} ${Language.donate}",
                            height: 22,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),

           /* Positioned(
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
                    color: ColorUtil.primary,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  //child: FittedBox(child: Text("+ ${Language.volunteer}",style: ts18(ColorUtil.themeBlack,fontsize: 16),)),
                  child: FittedText(
                    textStyle: ts18(ColorUtil.themeWhite,fontsize: 18,fontfamily: 'Reg'),
                    text: "+ ${Language.volunteer['Value']}",
                    height: 22,
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
                  //sw();
                  fadeRoute(DonateTreePage(
                    voidCallback: (){},
                    isDirectDonate: true,
                  ));
                },
                child: Stack(
                  children: [
                    *//*AvatarGlow(
                      glowColor: Colors.white54,
                      endRadius: 50.0,
                      shape: BoxShape.rectangle,
                      repeatPauseDuration: Duration(milliseconds: 500),
                      //duration: Duration(milliseconds: 2000),
                      repeat: true,
                      showTwoGlows: true,
                     child: Container(),
                    ),*//*

                    Container(
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
                        textStyle: ts18(ColorUtil.themeWhite,fontsize: 18,fontfamily: 'Reg'),
                        text:  "${MyConstants.rupeeString} ${Language.donate}",
                        height: 22,
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  void sw() async{
    var headers = {
      'authority': 'partner.swiggy.com',
      'accept': 'application/json, text/plain, */*',
      'accept-language': 'en-US,en;q=0.9',
      'content-type': 'application/json;charset=UTF-8',
      'cookie': 'WZRK_G=ecb7b99126214d4ba5055dfbfe4a2047; Swiggy_Session-alpha=5b491a4c-c714-423b-9d33-e3e314a182ba; Swiggy_Session-newSys=1; Swiggy_Session-user=619896; Swiggy_user_role=3; Swiggy_change_password=false; isRidBasedLogin=true; is_dot_in=1; 619896_prep_time_status=2; 619896_prep_time_blocker_status=true; Swiggy_Session-perms=%5B1%2C2%5D; WZRK_S_8RK-K65-846Z=%7B%22p%22%3A2%2C%22s%22%3A1677578237%2C%22t%22%3A1677579310%7D',
      'newrelic': 'eyJ2IjpbMCwxXSwiZCI6eyJ0eSI6IkJyb3dzZXIiLCJhYyI6IjczNzQ4NiIsImFwIjoiNTc3NDY5NDQiLCJpZCI6IjYwMGMyNGQ3NWZkZDhhMDYiLCJ0ciI6IjgwOTU0M2I2ZDA1OWIxMjU2YTk2YzJlYTkyZWNmNzcwIiwidGkiOjE2Nzc1NzkzMzQ5NTh9fQ==',
      'origin': 'https://partner.swiggy.com',
      'referer': 'https://partner.swiggy.com/orders',
      'sec-ch-ua': '"Chromium";v="110", "Not A(Brand";v="24", "Google Chrome";v="110"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"Windows"',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'same-origin',
      'traceparent': '00-809543b6d059b1256a96c2ea92ecf770-600c24d75fdd8a06-01',
      'tracestate': '737486@nr=0-1-737486-57746944-600c24d75fdd8a06----1677579334958',
      'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
      'Accept-Encoding': 'gzip',
    };

    var data = '{"restaurantTimeMap":[{"rest_rid":619896,"lastUpdatedTime":"2023-02-28T15:50:04"}],"sourceMessageIdMap":{"source":"POLLING_SERVICE"}}';

    var url = Uri.parse('https://partner.swiggy.com/orders/v1/fetch');
    var res = await http.post(url, headers: headers, body: data);
    if (res.statusCode != 200) throw Exception('http.post error: statusCode= ${res.statusCode}');
    print(res.body);
  }
}



