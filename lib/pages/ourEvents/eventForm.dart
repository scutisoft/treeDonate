import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:treedonate/widgets/accessWidget.dart';
import 'package:treedonate/widgets/searchDropdown/search2.dart';
import '../../utils/utils.dart';
import '../../widgets/alertDialog.dart';
import '../../widgets/loader.dart';
import '../../../HappyExtension/extensionHelper.dart';
import '../../../HappyExtension/utilWidgets.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../../helper/language.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/logoPicker.dart';
import '../../widgets/searchDropdown/dropdown_search.dart';


class EventsForm extends StatefulWidget {
  bool isEdit;
  String dataJson;
  Function? closeCb;
  EventsForm({this.closeCb,this.dataJson="",this.isEdit=false});

  @override
  _EventsFormState createState() => _EventsFormState();
}

class _EventsFormState extends State<EventsForm> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


  List<dynamic> widgets=[];
  ScrollController? silverController;

  @override
  void initState(){
    silverController= ScrollController();
    assignWidgets();
    super.initState();
  }

  RxList<dynamic> seedTreeList = RxList<dynamic>();
  var node;

  String page="EventDetails";
  var isKeyboardVisible=false.obs;

  TraditionalParam traditionalParam=TraditionalParam(
    insertSp: "USP_Events_InsertEventDetails",
    updateSp: "USP_Events_UpdateEventDetails",
    getByIdSp: "USP_Events_GetEventDetailsById"
  );


  //var dateTime=null.obs;

  Rxn<DateTime> dateTime=Rxn<DateTime>();
  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    isKeyboardVisible.value = MediaQuery.of(context).viewInsets.bottom != 0;
    return SafeArea(
        bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Color(0XFFF3F3F3),
          resizeToAvoidBottomInset: true,
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Color(0XFFF3F3F3),
                  expandedHeight: 160.0,
                  leading: ArrowBack(
                    iconColor: ColorUtil.themeBlack,
                    onTap: (){
                      Get.back();
                    },
                  ),
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    //expandedTitleScale: 1.8,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Add Events',style: ts18(ColorUtil.themeBlack,fontfamily: 'Bold'),textAlign: TextAlign.left,),
                        Text('Form',style: ts12(ColorUtil.themeBlack,fontfamily: 'Med'),textAlign: TextAlign.left,)
                      ],
                    ),
                    background: Image.asset('assets/trees/green-pasture-with-mountain.jpg',fit: BoxFit.cover,),
                  ),
                ),
              ];
            },
            body:Stack(
              children: [
                Container(
                  height: SizeConfig.screenHeight,
                  child:  ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                          padding: const EdgeInsets.only(left: 15,top: 15,bottom: 10),
                          child: Text('Add Event Details',
                            style: ts16(ColorUtil.themeBlack,fontfamily: 'Med'), )
                      ),
                      widgets[0],
                      GestureDetector(
                        onTap: () {
                          DatePicker.showDateTimePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2018, 3, 5),
                             // maxTime: DateTime(2019, 6, 7),
                              onChanged: (date) {},
                              onConfirm: (date) {
                                print('confirm $date');
                                dateTime.value=date;
                              },
                              currentTime: dateTime.value,
                              locale: LocaleType.en
                          );
                        },
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.only(left: 15,right: 15,top: 10),
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: ColorUtil.themeWhite,
                            border: Border.all(color: addNewTextFieldBorder)
                          ),
                          child: Obx(() => Text("Date & Time : ${dateTime.value==null?"":DateFormat("dd-MM-yyyy  HH:mm:ss").format(dateTime.value!)}",
                            style: ts20(ColorUtil.text3,fontsize: 15),)),
                        )
                      ),
                      widgets[1],
                      widgets[2],
                      widgets[3],
                      widgets[4],
                      widgets[5],
                      widgets[6],
                      widgets[7],
                      widgets[8],

                      const SizedBox(height: 100,),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child:AccessWidget(
                    hasAccess: true,
                    needToHide: true,
                    widget: Obx(() => Container(
                      margin: const EdgeInsets.only(top: 0,bottom: 0),
                      height: isKeyboardVisible.value?0:70,
                      width: SizeConfig.screenWidth,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Get.back();
                            },
                            child: Container(
                              width: SizeConfig.screenWidth!*0.4,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: ColorUtil.primary),
                                color: ColorUtil.primary.withOpacity(0.3),
                              ),
                              child:Center(child: Text(Language.cancel,style: ts16(ColorUtil.primary,), )) ,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              sysSubmit(widgets,
                                  isEdit: widget.isEdit,
                                  successCallback: (e){
                                    console("sysSubmit $e");
                                    if(widget.closeCb!=null){
                                      widget.closeCb!(e);
                                    }
                                  },
                                  needCustomValidation: true,
                                  onCustomValidation: (){
                                    if(dateTime.value==null){
                                      CustomAlert().cupertinoAlert("Select Date & Time");
                                      return false;
                                    }
                                    foundWidgetByKey(widgets, "EventDate",value: dateTime.value==null?null:DateFormat(MyConstants.dbDateTimeFormat).format(dateTime.value!),needSetValue: true);
                                    return true;

                                  },
                                  developmentMode: DevelopmentMode.traditional,
                                  traditionalParam: traditionalParam
                              );
                            },
                            child: Container(
                              width: SizeConfig.screenWidth!*0.4,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: ColorUtil.primary,
                              ),
                              child:Center(child: Text(Language.save,style: ts16(ColorUtil.themeWhite,), )) ,
                            ),
                          ),
                        ],
                      ),
                    )),
                  ),
                ),

                ShimmerLoader(),
              ],
            ),
          ),
        )
    );
  }

  @override
  void assignWidgets() async{

    widgets.add(AddNewLabelTextField(
      dataname: 'EventName',
      hasInput: true,
      required: true,
      labelText: Language.eventName,
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//0
   /* widgets.add(AddNewLabelTextField(
      dataname: 'EventDate',
      hasInput: true,
      required: true,
      labelText: Language.date,
      textInputType: TextInputType.number,
      suffixIcon: const Icon(Icons.date_range_outlined),
      textLength: 10,
      regExp: MyConstants.digitRegEx,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//1*/
    widgets.add(SearchDrp2(map:  {"dataName":"DistrictId","hintText":Language.selDistrict,"labelText":Language.district,"showSearch":true,"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},
        onchange: (e){
          fillTreeDrp(widgets, "TalukId",page: page,refId: e['Id']);
        }
    ));//2
    widgets.add(SearchDrp2(map:  {"dataName":"TalukId","hintText":Language.selTaluk,"labelText":Language.taluk,"showSearch":true,"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},
        onchange: (e){
          fillTreeDrp(widgets, "VillageId",page: page,refId: e['Id'],toggleRequired: true);
        })); //3
    widgets.add(SearchDrp2(map:  {"dataName":"VillageId","hintText":Language.selVillage,"labelText":Language.village,"showSearch":true,"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},)
    );//4
    widgets.add(SearchDrp2(map:  {"dataName":"LandId","hintText":Language.landType,"labelText":Language.selLandType}, required: false,));//5
    widgets.add(AddNewLabelTextField(
      dataname: 'NoOfPlants',
      hasInput: true,
      required: false,
      labelText: Language.noPlant,
      textInputType: TextInputType.number,
      regExp: MyConstants.digitRegEx,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//6
    widgets.add(AddNewLabelTextField(
      dataname: 'Place',
      hasInput: true,
      required: false,
      labelText: Language.eventPlace,
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//7

    widgets.add(AddNewLabelTextField(
      dataname: 'EventParagraph',
      hasInput: true,
      required: false,
      maxlines: null,
      labelText: Language.description,
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));

    widgets.add( MultiImagePicker(
      dataname: "EventImageFileList",
      hasInput: true,
      required: false,
      folder: "Event",
      developmentMode: DevelopmentMode.traditional,
      imageFileNameKey: "EventImageFileList",
      imagePathKey: "ImageFile",
    ));//8

    widgets.add(HiddenController(dataname: 'EventId'));
    widgets.add(HiddenController(dataname: 'EventDate'));

    await parseJson(widgets, General.EventsFormViewIdentifier,dataJson: widget.dataJson,traditionalParam: traditionalParam,
    developmentMode: DevelopmentMode.traditional,resCb: (e){

      if(e['Table']!=null && e['Table'].length>0){
        if(!checkNullEmpty(e['Table'][0]['EventDate'])){
          console("parseJson $e");
          dateTime.value=DateTime.parse(e['Table'][0]['EventDate']);
        }
      }
      widgets[8].setValue(e['Table1']);
    });
    fillTreeDrp(widgets, "DistrictId",page: page,clearValues: false);
    fillTreeDrp(widgets, "LandId",page: page,clearValues: false);
  }


  @override
  String getPageIdentifier(){
    return General.EventsFormViewIdentifier;
  }

}
