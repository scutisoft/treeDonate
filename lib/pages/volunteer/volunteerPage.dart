import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../HappyExtension/utils.dart';
import '../../api/ApiManager.dart';
import '../../pages/volunteer/viewVolunteer.dart';
import '../../utils/utils.dart';
import '../../widgets/alertDialog.dart';
import '../../widgets/animatedSearchBar.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/listView/HE_ListView.dart';
import '../../widgets/loader.dart';
import '../../widgets/recase.dart';
import '../../utils/general.dart';
import '../../HappyExtension/extensionHelper.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/navigationBarIcon.dart';
import '../Filter/FilterItems.dart';
import '../landParcel/LandParcelViewPage.dart';
import 'addvolunteer.dart';
import 'volunteerFilter.dart';

class VolunteerPage extends StatefulWidget {
  VoidCallback voidCallback;
  VolunteerPage({super.key, required this.voidCallback});

  @override
  _VolunteerPageState createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> with HappyExtensionHelper  implements HappyExtensionHelperCallback{
  

  List<Widget> widgets=[];

  List<dynamic> volunteerList=[];
  List<dynamic> filterVolunteerList=[];

  RxDouble silverBodyTopMargin=RxDouble(0.0);
  ScrollController? silverController;
  TextEditingController textController = TextEditingController();

  late HE_ListViewBody he_listViewBody;
  late TestBuilder testBuilder;

  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((_){
      silverController=ScrollController();
      silverBodyTopMargin.value=0.0;
      silverController!.addListener(() {
        if(silverController!.offset>triggerOffset){
            silverBodyTopMargin.value=toolBarHeight-(-(silverController!.offset-flexibleSpaceBarHeight));
            if(silverBodyTopMargin.value<0){
              silverBodyTopMargin.value=0;
            }
        }
        else if(silverController!.offset<triggerEndOffset){
            silverBodyTopMargin.value=0;
        }
      });
    });
    he_listViewBody=HE_ListViewBody(data: [],  getWidget: (e){
      return HE_VListViewContent(data: e,onEdit: (e){ console("onEdit $e");he_listViewBody.updateArrById("VolunteerId", e);},);
    },);
    testBuilder= TestBuilder(cardWith: SizeConfig.screenWidth!-(55+30));
    assignWidgets();
    super.initState();
  }
  var node;

  double cardWith=0.0;

  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    cardWith=SizeConfig.screenWidth!-(55+30);
    return SafeArea(
      bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Color(0XFFF3F3F3),
          resizeToAvoidBottomInset: true,
          body: NestedScrollView(
            controller: silverController,
            // floatHeaderSlivers: true,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: const Color(0XFFF3F3F3),
                  expandedHeight: 160.0,
                  pinned: true,
                  leadingWidth: 50.0,
                  leading: NavBarIcon(
                    onTap: (){
                      widget.voidCallback();
                    },
                  ),
                  /*leading: GestureDetector(
                      onTap: (){
                        widget.voidCallback();
                      },
                      child: Icon(Icons.arrow_back_ios_new_sharp,color: ColorUtil.themeBlack,size: 25,)
                  ),*/
                  flexibleSpace:  FlexibleSpaceBar(
                    expandedTitleScale: 1.5,
                    centerTitle: false,
                    titlePadding: EdgeInsets.only(left: 50,bottom: 16),
                    title: Text('Volunteer Details',style: TextStyle(fontSize: 18,color: ColorUtil.themeBlack,fontFamily: 'RM')),
                    background: Container(
                        alignment: Alignment.centerRight,
                        child: Image.asset('assets/Slice/volunteer.png',fit: BoxFit.contain,)
                    ),
                  ),
                ),
              ];
            },
            body:Container(
              // height: SizeConfig.screenHeight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //SizedBox(height: 50,),
                  Obx(() => Container(
                    height: 50,
                    margin: EdgeInsets.only(top: (10+silverBodyTopMargin.value),bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AnimSearchBar(
                          width: SizeConfig.screenWidth!-80,
                          color: ColorUtil.asbColor,
                          boxShadow: ColorUtil.asbBoxShadow,
                          textController: textController,
                          closeSearchOnSuffixTap: ColorUtil.asbCloseSearchOnSuffixTap,
                          searchIconColor: ColorUtil.asbSearchIconColor,
                          suffixIcon: ColorUtil.getASBSuffix(),
                          onSubmitted: (a){
                          },
                          onChange: (a){
                            filterVolunteerList=searchGrid(a,volunteerList,filterVolunteerList);
                            setState(() {});
                          },

                          onSuffixTap: () {
                            filterVolunteerList=searchGrid("",volunteerList,filterVolunteerList);
                            setState(() {});
                          },
                        ),
                        const SizedBox(width: 5,),
                        FilterIcon(
                          onTap: (){
                            fadeRoute(VolunteerFilter());
                          },
                        ),
                        SizedBox(width: 15,),
                      ],
                    ),
                  ),),
                  /*Flexible(
                    child: HE_ListViewBody(
                      data: volunteerList,
                      getWidget: (e){
                        return HE_VListViewContent(data: e,);
                      },
                     // widget: HE_VListViewContent(data: {},),
                    ),
                  ),*/
                  he_listViewBody,
                 // Flexible(child:testBuilder),
                 /* Flexible(
                    child: ListView.builder(
                    // scrollDirection: Axis.vertical,
                    itemCount: filterVolunteerList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (ctx,i){
                      console("hi");
                      return GestureDetector(
                        onTap: null,
                        child: Container(
                          margin: EdgeInsets.only(bottom: i==filterVolunteerList.length-1? 30:3,left: 15,right: 15),
                          padding: const EdgeInsets.only(left: 15.0,right: 10.0),
                          width: SizeConfig.screenWidth!*1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0XFFffffff),
                          ),
                          clipBehavior:Clip.antiAlias,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: cardWith*0.65,
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment:CrossAxisAlignment.start ,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(child: Text('${filterVolunteerList[i]['VolunteerName']}',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RM'),)),
                                    const SizedBox(height: 3,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Date :',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                                        Text('${filterVolunteerList[i]['JoinedDate']}',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RM'),),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Phone No :',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                                        Text('${filterVolunteerList[i]['VolunteerContactNo']}',style: TextStyle(color: ColorUtil.primary,fontSize: 14,fontFamily: 'RM'),),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Location :',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                                        Text(filterVolunteerList[i]['DistrictName'].toString().titleCase,style: TextStyle(color: ColorUtil.primary,fontSize: 14,fontFamily: 'RM'),),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Role :',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                                        Text(filterVolunteerList[i]['VolunteerRole'].toString().titleCase,style: TextStyle(color: ColorUtil.primary,fontSize: 14,fontFamily: 'RM'),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              //Spacer(),
                              Container(
                                width: 30,
                                alignment:Alignment.topRight,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 15,
                                      height:10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft:Radius.circular(50) ),
                                        color: Color(0xFFF2F3F7),
                                      ),
                                    ),
                                    Container(width: 1,height:90,color: Color(0xFFF2F3F7),),
                                    Container(
                                      width: 15,
                                      height:10,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft:Radius.circular(50) ),
                                        color: Color(0xFFF2F3F7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      width: cardWith*0.35,
                                      height: 50,
                                      alignment:Alignment.center,
                                      // color:Colors.red,
                                      child: Image.asset('assets/Slice/DefaultVolunteer.png',)
                                  ),
                                  const SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      EyeIcon(
                                        onTap: (){
                                          fadeRoute(VolunteerView(dataJson: jsonEncode(filterVolunteerList[i]['DataJson']??[]),isEdit: true,closeCb: (e){
                                            updateArrById("VolunteerId", e['Table'][0], filterVolunteerList,action: ActionType.update);
                                            setState(() {});
                                          },));
                                        },
                                      ),
                                      const SizedBox(width: 10,),
                                      GridDeleteIcon(
                                        hasAccess: isHasAccess(accessId["VolunteerDelete"]),
                                        onTap: (){
                                          sysDelete(filterVolunteerList, "VolunteerId",volunteerList,dataJson: getDataJsonForGrid(filterVolunteerList[i]['DataJson']),
                                            successCallback: (e){
                                              setState(() {});
                                            },
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                   ),
                  ),*/
                  ShimmerLoader(),
               //   NoData(show: filterVolunteerList.isEmpty),
                  //Obx(() => NoData(show: filterVolunteerList.isEmpty && !showLoader.value,)),

                /*  Container(
                    child: Stack(
                      children: [

                        NoData(show: volunteerList.isEmpty,)
                      ],
                    ),
                  )*/
                ],
              ),
            ),
          ),

        ),
    );
  }



  void onEdit(){

  }

  @override
  void assignWidgets() async{
    getData({});
  }

  void getData(dataJson) async{
    await parseJson(widgets, General.volunteerDetailIdentifier,dataJson: jsonEncode(dataJson));
    volunteerList=valueArray.where((element) => element['key']=="VolunteerList").toList()[0]['value'];
    filterVolunteerList=volunteerList;
    he_listViewBody.assignWidget(volunteerList);
    testBuilder.filterVolunteerList.value=volunteerList;
  //  setState(() {});
  }

  @override
  String getPageIdentifier(){
    return General.volunteerDetailIdentifier;
  }
}

class TestBuilder extends StatelessWidget {
  double cardWith;
  TestBuilder({Key? key,required this.cardWith}) : super(key: key);

  var filterVolunteerList=[].obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
      // scrollDirection: Axis.vertical,
      itemCount: filterVolunteerList.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (ctx,i){
        console("hi $i");
        return GestureDetector(
          onTap: null,
          child: Container(
            margin: EdgeInsets.only(bottom: i==filterVolunteerList.length-1? 30:3,left: 15,right: 15),
            padding: const EdgeInsets.only(left: 15.0,right: 10.0),
            width: SizeConfig.screenWidth!*1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0XFFffffff),
            ),
            clipBehavior:Clip.antiAlias,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: cardWith*0.65,
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start ,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(child: Text('${filterVolunteerList[i]['VolunteerName']}',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RM'),)),
                      const SizedBox(height: 3,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Date :',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                          Text('${filterVolunteerList[i]['JoinedDate']}',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RM'),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Phone No :',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                          Text('${filterVolunteerList[i]['VolunteerContactNo']}',style: TextStyle(color: ColorUtil.primary,fontSize: 14,fontFamily: 'RM'),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Location :',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                          Text(filterVolunteerList[i]['DistrictName'].toString().titleCase,style: TextStyle(color: ColorUtil.primary,fontSize: 14,fontFamily: 'RM'),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Role :',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                          Text(filterVolunteerList[i]['VolunteerRole'].toString().titleCase,style: TextStyle(color: ColorUtil.primary,fontSize: 14,fontFamily: 'RM'),),
                        ],
                      ),
                    ],
                  ),
                ),
                //Spacer(),
                Container(
                  width: 30,
                  alignment:Alignment.topRight,
                  child: Column(
                    children: [
                      Container(
                        width: 15,
                        height:10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft:Radius.circular(50) ),
                          color: Color(0xFFF2F3F7),
                        ),
                      ),
                      Container(width: 1,height:90,color: Color(0xFFF2F3F7),),
                      Container(
                        width: 15,
                        height:10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft:Radius.circular(50) ),
                          color: Color(0xFFF2F3F7),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width: cardWith*0.35,
                        height: 50,
                        alignment:Alignment.center,
                        // color:Colors.red,
                        child: Image.asset('assets/Slice/DefaultVolunteer.png',)
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        EyeIcon(
                          onTap: (){
                            filterVolunteerList[i]=filterVolunteerList[i];
                            return;
                            fadeRoute(VolunteerView(dataJson: jsonEncode(filterVolunteerList[i]['DataJson']??[]),isEdit: true,closeCb: (e){
                              //updateArrById("VolunteerId", e['Table'][0], filterVolunteerList,action: ActionType.update);
                             filterVolunteerList[i]=e['Table'][0];
                            },));
                          },
                        ),
                        const SizedBox(width: 10,),
                        GridDeleteIcon(
                          hasAccess: isHasAccess(accessId["VolunteerDelete"]),
                          onTap: (){
                           /* sysDelete(filterVolunteerList, "VolunteerId",volunteerList,dataJson: getDataJsonForGrid(filterVolunteerList[i]['DataJson']),
                              successCallback: (e){
                                setState(() {});
                              },
                            );*/
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}



class HE_VListViewContent extends StatelessWidget implements HE_ListViewContentExtension{
  Map data;
  Function(Map) onEdit;
  HE_VListViewContent({Key? key,required this.data,required this.onEdit}) : super(key: key){
    dataListener.value=data;
  }

  var dataListener={}.obs;

  @override
  Widget build(BuildContext context) {
    console("child render");
    return Obx(
            ()=> GestureDetector(
              onTap: (){
                dataListener.value={"VolunteerRole":Random().nextDouble().toString()};
                return;
                fadeRoute(VolunteerView(dataJson: jsonEncode(dataListener['DataJson']??[]),isEdit: true,closeCb: (e){
                                             //updateArrById("VolunteerId", e['Table'][0], dataListener,action: ActionType.update);
                  dataListener.value=e['Table'][0];
                  onEdit(e['Table'][0]);
                                           },));
              },
              child: Container(
                child: Text("${dataListener["VolunteerName"]??"Vlunter"} ${dataListener["VolunteerRole"]}"),
              ),
            )
    );
  }

  @override
  updateData(Map data) {
    dataListener.value=data;
  }
}
