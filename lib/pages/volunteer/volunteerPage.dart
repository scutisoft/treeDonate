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

  RxDouble silverBodyTopMargin=RxDouble(0.0);
  ScrollController? silverController;
  TextEditingController textController = TextEditingController();

  late HE_ListViewBody he_listViewBody;

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

    he_listViewBody=HE_ListViewBody(
      data: [],
      getWidget: (e){
        return HE_VListViewContent(
            data: e,
            cardWith: SizeConfig.screenWidth!-(55+30),
            onDelete: (dataJson){
                sysDeleteHE_ListView(he_listViewBody, "VolunteerId",dataJson: dataJson);
            },
          onEdit: (updatedMap){
              he_listViewBody.updateArrById("VolunteerId", updatedMap);
          },
        );
      },
    );

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
          backgroundColor: const Color(0XFFF3F3F3),
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
            body:Stack(
              children: [
                Column(
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
                              he_listViewBody.searchHandler(a);
                            },
                            onSuffixTap: (clear) {
                              if(clear){
                                he_listViewBody.searchHandler("");
                              }
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

                    Flexible(child:he_listViewBody),
                  ],
                ),
                ShimmerLoader(),
              ],
            ),
          ),
        ),
    );
  }

  @override
  void assignWidgets() async{
    getData({});
  }

  void getData(dataJson) async{
    await parseJson(widgets, General.volunteerDetailIdentifier,dataJson: jsonEncode(dataJson));
    List<dynamic> volunteerList=valueArray.where((element) => element['key']=="VolunteerList").toList()[0]['value'];
    he_listViewBody.assignWidget(volunteerList);
    //  setState(() {});
  }

  @override
  String getPageIdentifier(){
    return General.volunteerDetailIdentifier;
  }
}

class HE_VListViewContent extends StatelessWidget implements HE_ListViewContentExtension{
  double cardWith;
  Map data;
  Function(Map)? onEdit;
  Function(String)? onDelete;
  HE_VListViewContent({Key? key,required this.data,this.onEdit,required this.cardWith,this.onDelete}) : super(key: key){
    dataListener.value=data;
  }

  var dataListener={}.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
            ()=> Container(
              margin: EdgeInsets.only(bottom: /*i==filterVolunteerList.length-1? 30:*/3,left: 15,right: 15),
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
                        Flexible(child: Text('${dataListener['VolunteerName']}',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RM'),)),
                        const SizedBox(height: 3,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Date :',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                            Text('${dataListener['JoinedDate']}',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: 'RM'),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Phone No :',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                            Text('${dataListener['VolunteerContactNo']}',style: TextStyle(color: ColorUtil.primary,fontSize: 14,fontFamily: 'RM'),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Location :',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                            Text(dataListener['DistrictName'].toString().titleCase,style: TextStyle(color: ColorUtil.primary,fontSize: 14,fontFamily: 'RM'),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Role :',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                            Text(dataListener['VolunteerRole'].toString().titleCase,style: TextStyle(color: ColorUtil.primary,fontSize: 14,fontFamily: 'RM'),),
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
                              fadeRoute(VolunteerView(dataJson: getDataJsonForGrid(dataListener['DataJson']),isEdit: true,closeCb: (e){
                                updateDataListener(e['Table'][0]);
                                if(onEdit!=null){
                                  onEdit!(e['Table'][0]);
                                }
                              },));
                            },
                          ),
                          const SizedBox(width: 10,),
                          GridDeleteIcon(
                            hasAccess: isHasAccess(accessId["VolunteerDelete"]),
                            onTap: (){
                              if(onDelete!=null){
                                onDelete!(getDataJsonForGrid(dataListener['DataJson']));
                              }
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
    );
  }

  @override
  updateDataListener(Map data) {
    data.forEach((key, value) {
      if(dataListener.containsKey(key)){
        dataListener[key]=value;
      }
    });
  }
}
