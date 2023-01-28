import 'package:flutter/material.dart';
import '../../utils/general.dart';
import '../../HappyExtension/extensionHelper.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/innerShadowTBContainer.dart';
import '../../widgets/timeLine/connectors.dart';
import '../../widgets/timeLine/indicators.dart';
import '../../widgets/timeLine/timeline_tile_builder.dart';
import '../../widgets/timeLine/timelines.dart';

class NotificationPage extends StatefulWidget {
  VoidCallback voidCallback;
  NotificationPage({required this.voidCallback});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with TickerProviderStateMixin  implements HappyExtensionHelperCallback{
  late TabController _tabController;

  List<Widget> widgets=[];
  ScrollController? silverController;
  @override
  void initState(){
    silverController= ScrollController();
    assignWidgets();
    _tabController = TabController(length: 3,  vsync: this);
    super.initState();
  }
  var node;
  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    return SafeArea(
      bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          body:  Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Container(
                  height: 120,
                  //  clipBehavior: Clip.antiAlias,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                  //       color: tn.primaryColor
                  //   ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5,),
                      Container(
                        height: 60,
                        margin:  EdgeInsets.only(left:15.0,right: 15.0),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap:(){
                                  widget.voidCallback();
                                },
                                child: Container(
                                    height: 50,
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(Icons.grid_view_outlined,color:Colors.black45,size: 25,)
                                )
                            ),
                            SizedBox(width: 5,),
                            Text('Notification',style: TextStyle(fontFamily: 'RB',fontSize: 16,color: Colors.black,letterSpacing: 0.1)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left:20,right: 20),
                        padding: EdgeInsets.only(left: 25,right: 25),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorUtil.primary
                        ),
                        child: TabBar(
                            controller: _tabController,
                            // give the indicator a decoration (color and border radius)
                            indicatorPadding: EdgeInsets.only(top: 45),
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0,),
                              color:Colors.white,
                            ),
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorWeight: 6,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.white,
                            unselectedLabelStyle: TextStyle(fontSize: 14,fontFamily: 'RR'),
                            labelStyle: TextStyle(fontSize: 14,fontFamily: 'RR'),
                            tabs: [
                              Tab(text:"Donation"),
                              Tab(text:"Volunteer"),
                              Tab(text:"View all"),
                            ]
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: SizeConfig.screenHeight!-170,
                  width: SizeConfig.screenWidth!*1,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Align(
                        alignment:Alignment.topCenter,
                        child: Container(
                          width: SizeConfig.screenWidth!*1,
                          child: Column(
                            children: [
                              SizedBox(height: 20,),
                              Container(
                                margin: EdgeInsets.only(bottom: 15,left: 20,right: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Notifications  (12)',style: TextStyle(fontSize: 14,fontFamily: 'RB',color: Color(0xff2E2E2D),fontWeight: FontWeight.w600),),
                                    Text('View all',style: TextStyle(fontSize: 14,fontFamily: 'RR',color: Color(0xffA1A1A1),),)
                                  ],
                                ),
                              ),
                              InnerShadowTBContainer(
                                height: SizeConfig.screenHeight!-230,
                                width: SizeConfig.screenWidth!*1,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: 20,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (ctx,i){
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 15,left: 20,right: 20,top:i==0? 10:0),
                                      width: SizeConfig.screenWidth!*1,
                                      height: 80,
                                      decoration:i==0? BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Color(0XFFF5F5F5)),
                                        boxShadow: [
                                          BoxShadow(color: Colors.black26, spreadRadius: 0,blurRadius: 9,
                                            offset: Offset(
                                              0.0, // Move to right 10  horizontally
                                              5.0, // Move to bottom 10 Vertically),
                                            ),),
                                        ],
                                        color: Color(0XFFffffff),
                                      ): BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Color(0XFFF5F5F5)),
                                        color: Color(0XFFffffff),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                    width: 40,
                                                    height: 40,
                                                    margin: EdgeInsets.only(left: 10),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(50),
                                                      color: ColorUtil.primary,
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Icon(Icons.mail_outline,color: Colors.white,size: 20,)
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(left: 10),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Our shop lunched padi',style: TextStyle(fontSize: 14,fontFamily: 'RM',color: Color(0xff808080),),),
                                                      SizedBox(height: 5,),
                                                      Text('Your eligible this offer 3days only',style: TextStyle(fontSize: 13,fontFamily: 'RI',color: Color(0xffA1A1A1),),)
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            margin: EdgeInsets.only(right: 8,top: 10,bottom: 5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Opacity(
                                                    opacity:0.5,
                                                    child: Icon(Icons.delivery_dining_rounded,color:ColorUtil.primary,size: 20,)),
                                                Text('5 Min Ago',style: TextStyle(fontSize: 13,fontFamily: 'RR',color: Color(0xffA1A1A1),),)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )

                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        )
      );
  }

  @override
  void assignWidgets() async{
    widgets.clear();
    setState(() {});
  }
}
