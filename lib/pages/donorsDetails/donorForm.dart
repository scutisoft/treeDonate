
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


class DonorForm extends StatefulWidget {
  bool isEdit;
  String dataJson;
  Function? closeCb;
  DonorForm({this.closeCb,this.dataJson="",this.isEdit=false});

  @override
  _DonorFormState createState() => _DonorFormState();
}

class _DonorFormState extends State<DonorForm> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


  List<dynamic> widgets=[];
  ScrollController? silverController;

  @override
  void initState(){
    silverController= ScrollController();
    assignWidgets();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
    super.initState();
  }
  var node;

  String page="Events";
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
                        Text('Add Donor',style: ts18(ColorUtil.themeBlack,fontfamily: 'Bold'),textAlign: TextAlign.left,),
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
                          child: Text('Add Donor Details',
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
                     // widgets[8],
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
                              traditionalParam: TraditionalParam(
                                getByIdSp: Sp.getByIdNewsFeedDetail,
                                insertSp: Sp.insertNewsFeedDetail,
                                updateSp: Sp.updateNewsFeedDetail
                              )
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

    // widgets.add(AddNewLabelTextField(
    //   dataname: 'CompanyName',
    //   hasInput: true,
    //   required: true,
    //   maxlines: 1,
    //   labelText: 'Company Name',
    //   regExp: null,
    //   onChange: (v){},
    //   onEditComplete: (){
    //     node.unfocus();
    //   },
    // ));//0
    widgets.add(AddNewLabelTextField(
      dataname: 'ContactPerson',
      hasInput: true,
      required: true,
      maxlines: 1,
      labelText: 'Name',
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//1
    widgets.add(AddNewLabelTextField(
      dataname: 'PhoneNo',
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
      dataname: 'Email',
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
      dataname: 'GST',
      hasInput: true,
      required: true,
      maxlines: 1,
      labelText: 'GST',
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//4
    widgets.add(AddNewLabelTextField(
      dataname: 'Address',
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
      dataname: 'City',
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
    widgets.add(SearchDrp2(map:  {"dataName":"StateId","hintText":Language.selVillage,"labelText":"state","showSearch":true,"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},));//7
    widgets.add(AddNewLabelTextField(
      dataname: 'Pincode',
      hasInput: true,
      required: true,
      maxlines: null,
      labelText: 'Pincode',
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//8


    widgets.add(SingleImagePicker(dataname: "UserImage", folder: "Image",hasInput: true,required: true,));
    widgets.add(HiddenController(dataname: 'NewsFeedId'));

    await parseJson(widgets, General.ViewDonorFormIdentifier,dataJson: widget.dataJson,developmentMode: DevelopmentMode.json,
    traditionalParam: TraditionalParam(getByIdSp: Sp.getByIdNewsFeedDetail),resCb: (res){
      console("res $res");
      if(res['Table1']!=null && res['Table1'].isNotEmpty){
        widgets[1].setValue(res['Table1']);
      }
        });
  }


  @override
  String getPageIdentifier(){
    return General.ViewDonorFormIdentifier;
  }

}
