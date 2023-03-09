
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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


class CSRForm extends StatefulWidget {
  bool isEdit;
  String dataJson;
  Function? closeCb;
  CSRForm({this.closeCb,this.dataJson="",this.isEdit=false});

  @override
  _CSRFormState createState() => _CSRFormState();
}

class _CSRFormState extends State<CSRForm> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


  List<dynamic> widgets=[];
  ScrollController? silverController;
  TraditionalParam traditionalParam=TraditionalParam(
      getByIdSp: "USP_CSR_GetCSRDetailsById",
      insertSp: "USP_CSR_InsertCSRDetails",
      updateSp: "USP_CSR_UpdateCSRDetails"
  );

  @override
  void initState(){
    silverController= ScrollController();
    assignWidgets();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
    super.initState();
  }
  var node;

  String page="CSRDetails";
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
                        Text('Add CSR',style: ts18(ColorUtil.themeBlack,fontfamily: 'Bold'),textAlign: TextAlign.left,),
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
                          child: Text('Add CSR Details',
                            style: ts16(ColorUtil.themeBlack,fontfamily: 'Med'), )
                      ),
                      widgets[9],
                      widgets[0],
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
                                isEdit: widget.isEdit,
                                successCallback: (e){
                                  if(widget.closeCb!=null){
                                    widget.closeCb!(e);
                                  }
                                },
                                developmentMode: DevelopmentMode.traditional,
                              traditionalParam:traditionalParam
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
      dataname: 'CompanyName',
      hasInput: true,
      required: true,
      maxlines: 1,
      labelText: 'Company Name',
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//0
    widgets.add(AddNewLabelTextField(
      dataname: 'ContactPerson',
      hasInput: true,
      required: true,
      maxlines: 1,
      labelText: 'Contact Person',
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//1
    widgets.add(AddNewLabelTextField(
      dataname: 'ContactNumber',
      hasInput: true,
      required: true,
      maxlines: 1,
      textLength: 10,
      textInputType: TextInputType.number,
      labelText: 'Contact Number',
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//2
    widgets.add(AddNewLabelTextField(
      dataname: 'EmailId',
      hasInput: true,
      required: true,
      maxlines: 1,
      labelText: 'Email',
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//3
    widgets.add(AddNewLabelTextField(
      dataname: 'GSTNumber',
      hasInput: true,
      required: true,
      maxlines: 1,
      textLength: 15,
      labelText: 'GST',
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//4
    widgets.add(AddNewLabelTextField(
      dataname: 'CSRAddress',
      hasInput: true,
      required: true,
      maxlines: null,
      labelText: 'Address',
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//5
    widgets.add(AddNewLabelTextField(
      dataname: 'CSRCity',
      hasInput: true,
      required: true,
      maxlines: null,
      labelText: 'City',
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//6
    widgets.add(SearchDrp2(map:  {"dataName":"CSRStateId","hintText":"Select State","labelText":"state","showSearch":true,"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},));//7
    widgets.add(AddNewLabelTextField(
      dataname: 'CSRPincode',
      hasInput: true,
      required: true,
      maxlines: null,
      textInputType: TextInputType.number,
      textLength: 6,
      labelText: 'Pincode',
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//8


    widgets.add(SingleImagePicker(dataname: "CSRImageFileName", folder: "Image",hasInput: true,required: false,));
    widgets.add(HiddenController(dataname: 'CSRId'));

    await parseJson(widgets, General.CSRFormIdentifier,dataJson: widget.dataJson,
        developmentMode: DevelopmentMode.traditional,
    traditionalParam:traditionalParam,resCb: (res){
      console("2222 $res");

        });
    fillTreeDrp(widgets, "CSRStateId",page: page,clearValues: false);
  }


  @override
  String getPageIdentifier(){
    return General.CSRFormIdentifier;
  }

}
