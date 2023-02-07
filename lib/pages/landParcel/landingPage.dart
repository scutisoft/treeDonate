
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/api/ApiManager.dart';
import 'package:treedonate/api/apiUtils.dart';
import 'package:treedonate/pages/navHomeScreen.dart';
import 'package:treedonate/widgets/loader.dart';
import '../../HappyExtension/utils.dart';
import '../../utils/general.dart';
import '../../HappyExtension/extensionHelper.dart';
import '../../HappyExtension/utilWidgets.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../utils/utils.dart';
import '../../widgets/animatedSearchBar.dart';
import '../../widgets/navigationBarIcon.dart';
import '../../widgets/popupBanner/popup.dart';
import '../../widgets/staggeredGridView/src/widgets/staggered_grid.dart';
import '../../widgets/staggeredGridView/src/widgets/staggered_grid_tile.dart';
import '../Filter/FilterItems.dart';
import '../newsFeedsView/newsFeedsViewPage.dart';
import '../profile/myprofile.dart';

class LandingPage extends StatefulWidget {
  VoidCallback voidCallback;
  LandingPage({required this.voidCallback});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with HappyExtensionHelper  implements HappyExtensionHelperCallback{

  final List<String> imgList = [
    'assets/Slice/Landing-slider-sm.jpg',
    'assets/Slice/Landing-slider-sm-1.jpg',
    'assets/Slice/Landing-slider-sm-2.jpg',
  ];

  List<Widget> widgets=[];
  int _current = 0;
  final CarouselController _controller = CarouselController();

  List<dynamic> filterNewsFeed=[];
  List<dynamic> newsFeed=[];

  @override
  void initState(){
    assignWidgets();
    super.initState();
  }

  ScrollController? silverController;
  TextEditingController textController = TextEditingController();
  var node;

  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    return SafeArea(
      bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Color(0xFFe8e8e8),
          resizeToAvoidBottomInset: true,
          body: NestedScrollView(
            controller: silverController,
            // floatHeaderSlivers: true,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  elevation: 0,
                  toolbarHeight: 60,
                  backgroundColor: ColorUtil.theme,
                  leading: Container(),
                  actions: [
                    Container(
                      width: SizeConfig.screenWidth,
                      height: 80,
                      child: Container(
                          child:  Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NavBarIcon(
                                onTap:  (){
                                  widget.voidCallback();
                                },
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      widgets[0],
                                      widgets[1],
                                      // Text("Mr.Balasubramaniyan",style:  TextStyle(fontFamily: 'RB',fontSize: 15,color: ColorUtil.themeBlack),),
                                      // Text("Zone 7 Co-Ordinator",style:  TextStyle(fontFamily: 'RR',fontSize: 12,color: ColorUtil.themeBlack),),
                                    ],
                                  ),
                                  SizedBox(width: 5,),
                                  GestureDetector(
                                    onTap: (){
                                      setPageNumber(1);
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: ColorUtil.primary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(Icons.person_outline_outlined,color: ColorUtil.themeWhite,),
                                    ),
                                  ),
                                  // SizedBox(width: 5,),
                                  // GestureDetector(
                                  //   onTap: (){
                                  //
                                  //   },
                                  //   child: Container(
                                  //     height: 40,
                                  //     width: 40,
                                  //     alignment: Alignment.center,
                                  //     decoration: BoxDecoration(
                                  //       color: ColorUtil.themeWhite,
                                  //       shape: BoxShape.circle,
                                  //     ),
                                  //     child: Stack(
                                  //       children: [
                                  //         Icon(Icons.notifications,color:Colors.orangeAccent,size: 25,),
                                  //         Positioned(
                                  //           right: 0,
                                  //           top: 0,
                                  //           child: Container(
                                  //             height: 15,
                                  //             width: 15,
                                  //             alignment: Alignment.center,
                                  //             decoration: BoxDecoration(
                                  //               shape: BoxShape.circle,
                                  //               color: ColorUtil.red,
                                  //             ),
                                  //             child: Text("1",style:  TextStyle(fontFamily: 'RR',fontSize: 10,color: Colors.white),),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(width: 15,),
                                ],
                              ),
                            ],
                          ),
                      ),
                    ),
                  ],
                  floating: true,
                  snap: true,
                  pinned: true,
                ),
              ];
            },
            body: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 10,),
                Container(
                  height: 190,
                  width: SizeConfig.screenWidth!,
                  margin: const EdgeInsets.only(left: 15,right: 15),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        height: 160,
                        clipBehavior: Clip.antiAlias,
                        decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: CarouselSlider(
                          options: CarouselOptions(
                              height: 160,
                              enlargeCenterPage: false,
                              viewportFraction: 1,
                              scrollDirection: Axis.horizontal,
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              }
                          ),
                          carouselController: _controller,
                          items: imgList
                              .map((item) => Image.asset(
                            item, fit: BoxFit.cover,
                            width: SizeConfig.screenWidth,height: 160,))
                              .toList(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imgList
                            .asMap()
                            .entries
                            .map((entry) {
                          return GestureDetector(
                            onTap: () =>
                                _controller.animateToPage(entry.key),
                            child: Container(
                              width: 12.0,
                              height: 12.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme
                                      .of(context)
                                      .brightness == Brightness.dark
                                      ? Colors.white
                                      : ColorUtil.primary)
                                      .withOpacity(
                                      _current == entry.key ? 0.9 : 0.4)),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                ),
                const SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  child: buildGrid(),
                ),
                const SizedBox(height: 10,),

                // News&Feeds
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 15),
                        child: Text("News & Feeds",style: TextStyle(fontSize: 16,color: ColorUtil.themeBlack,fontFamily:'RM'), )

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AnimSearchBar(
                          width: SizeConfig.screenWidth!-182,
                          color: ColorUtil.asbColor,
                          boxShadow: ColorUtil.asbBoxShadow,
                          textController: textController,
                          closeSearchOnSuffixTap: ColorUtil.asbCloseSearchOnSuffixTap,
                          searchIconColor: ColorUtil.asbSearchIconColor,
                          suffixIcon: ColorUtil.getASBSuffix(),
                          onSubmitted: (a){},
                          onChange: (a){
                            filterNewsFeed=searchGrid(a,newsFeed,filterNewsFeed);
                            setState(() {});
                          },

                          onSuffixTap: () {
                            filterNewsFeed=searchGrid("",newsFeed,filterNewsFeed);
                            setState(() {});
                          },
                        ),
                        /*const SizedBox(width: 5,),
                        GestureDetector(
                          onTap: (){
                            fadeRoute(FilterItems());
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorUtil.primary,
                            ),
                            child: Icon(Icons.filter_alt_outlined,color:ColorUtil.themeBlack,),
                          ),
                        ),*/
                        const SizedBox(width: 15,),
                      ],
                    ),
                  ],
                ),

                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: filterNewsFeed.length,
                  itemBuilder: (ctx,i){
                    return getNewsFeed(
                      name: filterNewsFeed[i]['NFNAME']??"",
                      nfDescription: filterNewsFeed[i]['NFDescription']??"",
                      nfLoc: filterNewsFeed[i]['NFLocation']??"",
                      nfType: filterNewsFeed[i]['NFType']??"",
                      profileImg: filterNewsFeed[i]['NFProfileImage']??"",
                      date: filterNewsFeed[i]['NFDATE']??"",
                      time: filterNewsFeed[i]['NFTime']??"",
                      img:  filterNewsFeed[i]['NFImageFile']??"",
                    );
                  },
                ),
                ShimmerLoader(),
                NoData(show: filterNewsFeed.isEmpty),
                //Obx(() => NoData(show: filterNewsFeed.isEmpty && !showLoader.value,)),

                const SizedBox(height: 15,),

              ],
            ),
          ),
        ),
    );
  }
  StaggeredGrid buildGrid() {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children:  [
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.1,
          child: GestureDetector(
            onTap: (){
              if(isHasAccess(accessId["LandParcelView"])){
                setPageNumber(9);
              }

            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorUtil.primary.withOpacity(0.2)
              ),
              child:Stack(
                children: [
                  Image.asset('assets/Slice/Land-parcel.png',fit: BoxFit.cover,height: SizeConfig.screenHeight,width: SizeConfig.screenWidth,),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0,left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Land Parcel",style:TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RM',fontSize: 14,letterSpacing: 1.0),),
                           // Text("500 Hectare",style:TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RB',fontSize: 16,letterSpacing: 1.0),),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.3,
          child: GestureDetector(
            onTap: (){
             // setPageNumber(11);
            },
            child: Container(
              // width: SizeConfig.screenWidth!*0.4,
              // height: 250,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorUtil.primary.withOpacity(0.2)
              ),
              child:Stack(
                children: [
                  Image.asset('assets/Slice/seeds.png',height: SizeConfig.screenHeight,fit: BoxFit.cover,width: SizeConfig.screenWidth,),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0,left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Seed collection",style:TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RM',fontSize: 14,letterSpacing: 1.0),),
                          //  Text("500 Kg",style:TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RB',fontSize: 16,letterSpacing: 1.0),),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.3,
          child: GestureDetector(
            onTap: (){
              // setPageNumber(12);
            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorUtil.primary.withOpacity(0.2)
              ),
              child: Stack(
                children: [
                  Image.asset('assets/Slice/nursery.png',height: SizeConfig.screenHeight,fit: BoxFit.cover,width: SizeConfig.screenWidth,),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0,left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Nursery",style:TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RM',fontSize: 14,letterSpacing: 1.0),),
                           // Text("250 Numbers",style:TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RB',fontSize: 16,letterSpacing: 1.0),),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.1,
          child:GestureDetector(
            onTap: (){
              // setPageNumber(10);
            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorUtil.primary.withOpacity(0.2)
              ),
              child: Stack(
                children: [
                  Image.asset('assets/Slice/planting.png',height: SizeConfig.screenHeight,fit: BoxFit.fill,),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0,left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Plantings",style:TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RM',fontSize: 14,letterSpacing: 1.0),),
                           // Text("50,00,000",style:TextStyle(color: ColorUtil.themeWhite,fontFamily: 'RB',fontSize: 16,letterSpacing: 1.0),),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void assignWidgets() async{
    widgets.clear();
    newsFeed.clear();
    filterNewsFeed.clear();
    widgets.add(HE_Text(dataname: "UserName", contentTextStyle: TextStyle(fontFamily: 'RB',fontSize: 15,color: ColorUtil.themeBlack),));
    widgets.add(HE_Text(dataname: "Role", contentTextStyle: TextStyle(fontFamily: 'RR',fontSize: 12,color: ColorUtil.themeBlack),));
    await parseJson(widgets, General.HomePageViewIdentifier);


    try{
      newsFeed=valueArray.where((element) => element['key']=="NewsFeedList").toList()[0]['value'];
      filterNewsFeed= newsFeed;
    }
    catch(e){}
    setState(() {});

  }


  Widget getNewsFeed({String name="",String nfType="",String nfDescription="",String profileImg="",String nfLoc="",String date="",String time="",
    String img=""
  }){
    List<dynamic> imgList=[];
    List<String> imgListUrl=[];
    imgList=img.split(",");

    imgList.forEach((element) {
      imgListUrl.add(GetImageBaseUrl()+element);
    });

    Widget getImgContainer(path){
      return Image.network(GetImageBaseUrl()+path,fit: BoxFit.cover,);
    }

    Widget getImgByCount(cunt){
      if(cunt==1){
        return  SizedBox(
          width:SizeConfig.screenWidth,
          height: 200,
            child:getImgContainer(imgList[0])
        );
      }
      else if(cunt==2){
        return Container(
          height: 200,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width:SizeConfig.screenWidth!*0.50,
                height: 200,
                  child:getImgContainer(imgList[0])
              ),
              const SizedBox(width: 1,),
              SizedBox(
                width:(SizeConfig.screenWidth!*0.5)-31,
                height: 200,
                child:getImgContainer(imgList[1])
              )
            ],
          ),
        );
      }
      else if(cunt==3){
        return SizedBox(
          height: 200,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width:SizeConfig.screenWidth!*0.5,
                height: 200,
                child:getImgContainer(imgList[0])
              ),
              const SizedBox(width: 1,),
              SizedBox(
                width:(SizeConfig.screenWidth!*0.5)-31,
                height: 200,
                child: Column(
                  children: [
                    SizedBox(
                      width:SizeConfig.screenWidth,
                      height: 99.5,
                        child:getImgContainer(imgList[1])
                    ),
                    const SizedBox(height: 1,),
                    SizedBox(
                      width:SizeConfig.screenWidth,
                      height: 99.5,
                        child:getImgContainer(imgList[2])
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }
      return Container(height: 200,);
    }



    return Container(
      width: SizeConfig.screenWidth,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(left: 15,right: 15,bottom: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: ColorUtil.themeWhite
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              getImgByCount(imgList.length),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: ColorUtil.primary,
                        shape: BoxShape.circle,
                      ),
                     child: Image.network(GetImageBaseUrl()+profileImg,fit: BoxFit.contain,errorBuilder: (a,b,c){
                       return Icon(Icons.person_outline_outlined,color: ColorUtil.themeWhite,);
                     },),
                     // child: Icon(Icons.person_outline_outlined,color: ColorUtil.themeWhite,),
                    ),
                    SizedBox(width: 5,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(child: Text("$name",style:  TextStyle(fontFamily: 'RB',fontSize: 15,color: ColorUtil.themeBlack),)),
                        Text("$nfType",style:  TextStyle(fontFamily: 'RR',fontSize: 12,color: ColorUtil.themeBlack),),
                      ],
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("$time",style:  TextStyle(fontFamily: 'RB',fontSize: 13,color: ColorUtil.themeBlack),),
                        Text("$date",style:  TextStyle(fontFamily: 'RR',fontSize: 12,color: ColorUtil.themeBlack),),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10 ,),
              Padding(
                padding: const EdgeInsets.only(left: 15.0,right: 8.0),
                child: Text("$nfDescription",style:  TextStyle(fontFamily: 'RB',fontSize: 15,color: ColorUtil.themeBlack),),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on,color: ColorUtil.text4,),
                    SizedBox(width: 5,),
                    Text("$nfLoc",style:  TextStyle(fontFamily: 'RB',fontSize: 14,color: ColorUtil.text4),)
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Divider(
                thickness: 1,
                color: ColorUtil.text4,
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.people_alt_sharp,color: ColorUtil.text4,),
                        SizedBox(width: 8,),
                        Text("258",style:  TextStyle(fontFamily: 'RB',fontSize: 14,color: ColorUtil.text4),),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.comment,color: ColorUtil.primary,),
                        SizedBox(width: 8,),
                        Text("28",style:  TextStyle(fontFamily: 'RB',fontSize: 14,color: ColorUtil.text4),),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.thumb_up,color: ColorUtil.primary,),
                        SizedBox(width: 8,),
                        Text("5",style:  TextStyle(fontFamily: 'RB',fontSize: 14,color: ColorUtil.text4),),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          /*Positioned(
            top: 15,
            left: 15,
            child: Container(
              padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
              decoration: BoxDecoration(
                  color:Colors.orange,
                  borderRadius: BorderRadius.circular(3.0)
              ),
              child: Text("Admin",style: TextStyle(fontSize: 12,color: ColorUtil.themeWhite,fontFamily:'RM'), ),
            ),
          ),*/
          Positioned(
            top: 165,
            right: 20,
            child: GestureDetector(
              onTap: (){
                showHideDotsPopup(imgListUrl);
                //fadeRoute(NewsFeedsView());
              },
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ColorUtil.themeBlack,
                      blurRadius: 15.0, // soften the shadow
                      spreadRadius: 0.0, //extend the shadow
                      offset: Offset(
                        0.0, // Move to right 10  horizontally
                        0.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                  color: ColorUtil.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.remove_red_eye_outlined,color: ColorUtil.themeWhite,),
              ),
            ),
          )
        ],
      ),
    );
  }


  void showHideDotsPopup(images) {
    PopupBanner(
      context: context,
      images: images,
      useDots: true,
      autoSlide: false,
      onClick: (index) {
        debugPrint("CLICKED $index");
      },
      fit: BoxFit.contain
    ).show();
  }

}
