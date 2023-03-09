
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../api/sp.dart';
import '../../utils/utils.dart';
import '../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../../widgets/loader.dart';
import '../../../HappyExtension/extensionHelper.dart';
import '../../../HappyExtension/utilWidgets.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../helper/language.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/logoPicker.dart';
import '../../widgets/searchDropdown/dropdown_search.dart';


  class CSRAddAmount extends StatefulWidget {
  String dataJson;
  Function? closeCb;
  dynamic csrId;
  CSRAddAmount({this.closeCb,this.dataJson="",required this.csrId});

  @override
  _CSRAddAmountState createState() => _CSRAddAmountState();
}

class _CSRAddAmountState extends State<CSRAddAmount> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


  List<dynamic> widgets=[];
  ScrollController? silverController;
  TraditionalParam traditionalParam=TraditionalParam(
      insertSp: "USP_CSR_InsertCSRDonationDetails",
  );

  @override
  void initState(){
    silverController= ScrollController();
    assignWidgets();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
    super.initState();
  }

  var transactionId=false.obs;
  var node;
  final _controller = TextEditingController();
  String page="CSRAmountDetails";
  var isKeyboardVisible=false.obs;
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
                        Text('Add Amount',style: ts18(ColorUtil.themeBlack,fontfamily: 'Bold'),textAlign: TextAlign.left,),
                        Text(Language.form,style: ts12(ColorUtil.themeBlack,fontfamily: 'Med'),textAlign: TextAlign.left,)
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
                          child: Text('Add Amount',
                            style: ts16(ColorUtil.themeBlack,fontfamily: 'Med'), )
                      ),
                      widgets[0],
                      widgets[1],
                      widgets[2],
                      Obx(() => Visibility(
                        visible: transactionId.value,
                        child: widgets[3],),),
                      const SizedBox(height: 100,),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Obx(() => Container(
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
                                successCallback: (e){
                                  if(widget.closeCb!=null){
                                    widget.closeCb!(e);
                                  }
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
      dataname: 'DonationDate',
      hasInput: true,
      required: true,
      maxlines: 1,
      labelText: 'dd-mm-yyyy',
      suffixIcon: Icon(Icons.date_range_outlined),
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//0
    widgets.add(AddNewLabelTextField(
      dataname: 'DonationAmount',
      hasInput: true,
      required: true,
      maxlines: 1,
      labelText: 'Amount',
      textInputType: TextInputType.number,
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//1
    widgets.add(SearchDrp2(map:  {"dataName":"PaymentTypeId","hintText":"Payment Type","labelText":"Payment Type","showSearch":true,"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},
    onchange: (e){
      console(e);
      if(e['Id']==3044){
        transactionId.value=false;
      }
      else{
        transactionId.value=true;
      }
    },
    ));//7
    widgets.add(AddNewLabelTextField(
      dataname: 'PaymentReferenceNumber',
      hasInput: true,
      required: false,
      maxlines: 1,
      labelText: 'Transaction Number',
      textInputType: TextInputType.number,
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//3
    widgets.add(HiddenController(dataname: "CSRId",));
    await parseJson(widgets, General.CSRFormIdentifier,dataJson: widget.dataJson,
        developmentMode: DevelopmentMode.traditional, traditionalParam: traditionalParam,resCb: (res){
      console("res $res");
        });
    fillTreeDrp(widgets, "PaymentTypeId",page: page,clearValues: false);
    foundWidgetByKey(widgets, "CSRId",needSetValue: true,value: widget.csrId);
  }


  @override
  String getPageIdentifier(){
    return General.CSRAddAmountIdentifier;
  }

}
