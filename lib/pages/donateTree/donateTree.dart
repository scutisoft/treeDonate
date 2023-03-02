import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:treedonate/model/parameterMode.dart';
import 'package:treedonate/pages/donateTree/plantingplace.dart';
import 'package:treedonate/widgets/alertDialog.dart';
import 'package:treedonate/widgets/calculation.dart';
import 'package:treedonate/widgets/customAppBar.dart';
import 'package:treedonate/widgets/loader.dart';
import 'package:treedonate/widgets/navigationBarIcon.dart';

import '../../api/ApiManager.dart';
import '../../notifier/donatePaymentNotifier.dart';
import '../../utils/utils.dart';
import '../../utils/general.dart';
import '../../HappyExtension/extensionHelper.dart';
import '../../HappyExtension/utilWidgets.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../../widgets/innerShadowTBContainer.dart';
import '../../widgets/pinWidget.dart';
import '../navHomeScreen.dart';
import '../ourEvents/events.dart';
import 'paymentRedirect.dart';

class DonateTreePage extends StatefulWidget {
  VoidCallback voidCallback;
  bool isDirectDonate;
  DonateTreePage({required this.voidCallback,this.isDirectDonate=false});

  @override
  _DonateTreePageState createState() => _DonateTreePageState();
}

class _DonateTreePageState extends State<DonateTreePage> with HappyExtensionHelper  implements HappyExtensionHelperCallback{



  int selectedTreeCount=0;
  List<dynamic> Trees=[
    {"Text":"01 Trees","Value":1},
    {"Text":"10 Trees","Value":10},
    {"Text":"100 Trees","Value":100},
  ];

  List<Widget> widgets=[];

  var treePrice=0.0.obs;
  var totalCost=0.0.obs;
  var totalTrees=0.obs;

  TextEditingController customNoofTrees=TextEditingController();
  TextEditingController priceToDonate=TextEditingController();

  DonarInfo donaterInfo=DonarInfo(onDonateCb: (e){},);
  var isRupees=true.obs;

  @override
  void initState(){
    assignWidgets();
    donaterInfo.onDonateCb=onDonate;
    super.initState();
  }
  FocusNode _focusNode = FocusNode();
  var node;

  void onDonate(params){
    Get.back();
    params.add(ParameterModel(Key: "TotalAmount", Type: "string", Value: totalCost.value));
    donationAmt=totalCost.value.toString();
    generatePaymentLink(params,onPageClose: (){
      clearFrm();
    });
   /* Get.to(PaymentRedirecting(url: "https://rzp.io/i/pMVvZmUL",paymentResponse: (url){
      console("paymentResponse $url");
    },))!.then((value){ });*/
  }

  void clearFrm(){
    isRupees.value=false;
    donaterInfo.clearFrm();
    treeCalc(1);
  }

  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    return SafeArea(
      bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: ColorUtil.primary,
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                child: SingleChildScrollView(
                  child: Column(
                    children:[
                      Container(
                        width: SizeConfig.screenWidth,
                        height: 350,
                        decoration: const BoxDecoration(
                            image: DecorationImage(image: AssetImage('assets/Slice/Donate-bg.jpg'),fit:BoxFit.cover,)
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                                bottom:-70,
                                // right: 0,
                                left: -20,
                                child: Image.asset('assets/Slice/tree-animation.gif',fit: BoxFit.cover,height: 400,)),
                            Positioned(
                                top: 230,
                                left: 20,
                                child:Image.asset('assets/Slice/falling-leaves.gif',fit: BoxFit.cover,height: 100,)
                            ),
                            Positioned(
                              top: 230,
                              right: 20,
                              child:Transform.scale(
                                  scaleX: -1,
                                  child: Image.asset('assets/Slice/falling-leaves.gif',fit: BoxFit.cover,height: 100,gaplessPlayback: false,
                                    isAntiAlias: true,)
                              ),
                            ),
                            Container(
                              height: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  widget.isDirectDonate?
                                  ArrowBack(
                                    iconColor: ColorUtil.themeBlack,
                                    onTap: (){
                                      Get.back();
                                    },
                                  ):NavBarIcon(
                                    onTap: widget.voidCallback,
                                  ),
                                  Image.asset('assets/logo.png',width: 180,fit: BoxFit.cover,),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: GestureDetector(
                                      onTap: (){
                                        fadeRoute(const PlantingVillagePlace());
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 0,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: ColorUtil.primary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset('assets/Slice/tree-location.png',width: 30,fit: BoxFit.cover,),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: SizeConfig.screenHeight!-350,
                        // margin: EdgeInsets.only(top: 350),
                        decoration: BoxDecoration(
                            color: ColorUtil.themeWhite,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(25.0),topRight: Radius.circular(25.0))
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                color: ColorUtil.primary,
                                margin: const EdgeInsets.only(left: 20,right: 20),
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 5, bottom: 5),
                                child: Text('நம் மரம் நம் கடமை',style: TextStyle(fontSize: 14,color: ColorUtil.themeWhite,fontFamily: 'RM'),),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            /* Container(
                          margin: const EdgeInsets.only(left: 20,right: 20),
                          child: Text('Someone Setting in the shade today because someone planted a tree a long time ago',style: TextStyle(fontSize: 18,color: ColorUtil.themeBlack,fontFamily: 'RB'),),
                        ),
                        const SizedBox(height: 10,),*/
                            Container(
                                width: SizeConfig.screenWidth,
                                height: 80,
                                //  padding: EdgeInsets.only(bottom: 10),
                                alignment: Alignment.centerLeft,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: Trees.length,
                                  shrinkWrap: true,
                                  itemBuilder: (ctx,i){
                                    return  GestureDetector(
                                      onTap: (){
                                        customNoofTrees.clear();
                                        priceToDonate.clear();
                                        treeCalc(Trees[i]['Value']);
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 400),
                                        curve: Curves.easeIn,
                                        decoration:i==selectedTreeCount? BoxDecoration(
                                          borderRadius: BorderRadius.circular(25.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color:ColorUtil.primary.withOpacity(0.5),
                                              blurRadius: 5.0, // soften the shadow
                                              spreadRadius: 2, //extend the shadow
                                              offset: const Offset(
                                                2.0, // Move to right 10  horizontally
                                                2.0, // Move to bottom 10 Vertically
                                              ),
                                            )
                                          ],
                                          color:ColorUtil.primary,
                                        ):BoxDecoration(
                                          borderRadius: BorderRadius.circular(25.0),
                                          border: Border.all(color: const Color(0xffE2E2E2),style:BorderStyle.solid ),
                                          color:ColorUtil.greyLite,
                                        ) ,
                                        margin: EdgeInsets.only(right: 10,top: 10,bottom: 10,left: i==0?15:0),
                                        padding: const EdgeInsets.only(right: 20,top: 15,bottom: 15,left:20),
                                        alignment: Alignment.center,
                                        child:  Text(Trees[i]['Text'],style: TextStyle(fontFamily: 'RR',fontSize: 14,color: i==selectedTreeCount? Colors.white:const Color(0xff959595))),
                                      ),
                                    );
                                  },
                                )
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: ColorUtil.greyLite,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              margin: const EdgeInsets.only(left: 20,right: 20),
                              child: Row(
                                children: [

                                  GestureDetector(
                                      onTap:(){
                                        isRupees.value=!isRupees.value;
                                      },
                                      child: Obx(() => Container(
                                        width: 60,
                                        height: 60,
                                        color: Colors.transparent,
                                        alignment: Alignment.center,
                                        child: isRupees.value?Text('₹',style: TextStyle(fontSize: 24,color: ColorUtil.primary,fontFamily: 'RB'),):
                                        SvgPicture.asset("assets/Slice/nursery.svg",height: 25,color: ColorUtil.primary,),
                                      ),)
                                  ),
                                  Container(
                                    width: 1,
                                    height: 50,
                                    margin: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Color(0xffE3E4E8),
                                    ),
                                  ),
                                  Obx(() => Container(
                                    width: SizeConfig.screenWidth!-117,
                                    height: 60,
                                    padding: const EdgeInsets.only(left: 10),
                                    child: isRupees.value?TextField (
                                      controller: customNoofTrees,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Custom Number of Tree',
                                        labelStyle: TextStyle(
                                          color: _focusNode.hasFocus ? ColorUtil.primary : ColorUtil.text4,
                                        ),
                                        //hintText: 'Custom Number of Tree',
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        //LengthLimitingTextInputFormatter(textLength),
                                        FilteringTextInputFormatter.allow(RegExp(MyConstants.digitRegEx)),
                                      ],
                                      onChanged: (v){
                                        priceToDonate.clear();
                                        treeCalc(v);
                                      },
                                    ):TextField (
                                      controller: priceToDonate,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Donation Amount',
                                        labelStyle: TextStyle(
                                          color: _focusNode.hasFocus ? ColorUtil.primary : ColorUtil.text4,
                                        ),
                                        //hintText: 'Custom Number of Tree',
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        //LengthLimitingTextInputFormatter(textLength),
                                        FilteringTextInputFormatter.allow(RegExp(MyConstants.digitRegEx)),
                                      ],
                                      onChanged: (v){
                                        priceToTree(v);
                                      },
                                    ),
                                  ))
                                ],
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Container(
                              margin: const EdgeInsets.only(left: 20,right: 20),
                              height: 20,
                              child: Row(
                                children: [
                                  Text("Total Trees: ",style: ts20(ColorUtil.text1,fontsize: 14),),
                                  Obx(() => Text("${totalTrees.value}",style: ts20(ColorUtil.themeBlack,fontsize: 14),),)
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              margin: const EdgeInsets.only(left: 20,right: 20),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      // setPageNumber(5);

                                    },
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: ColorUtil.primary.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(20.0)
                                      ),
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(13.0),
                                        child: Image.asset('assets/Slice/tree-event.png',fit: BoxFit.cover,),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      if(totalCost.value<=0){
                                        CustomAlert().cupertinoAlert("Enter Amount or Select No of Trees to donate");
                                        return;
                                      }
                                      if(totalCost.value<MyConstants.minimumDonationAmount){
                                        CustomAlert().cupertinoAlert("Minimum Amount to donate is ${MyConstants.rupeeString} ${MyConstants.minimumDonationAmount}");
                                        return;
                                      }
                                      Get.to(donaterInfo);
                                    },
                                    child: Container(
                                        width: SizeConfig.screenWidth!-110,
                                        height: 60,
                                        margin: const EdgeInsets.only(left: 10.0),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: ColorUtil.primary,
                                            borderRadius: BorderRadius.circular(20.0)
                                        ),
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Obx(() => Text('PAY   ₹ ${formatCurrency.format(totalCost.value)}',style: TextStyle(fontSize: 18,color: ColorUtil.themeWhite,fontFamily: 'RB'),)
                                        )
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 20,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() => Loader(value: showLoader.value,),)
            ],
          ),
        ),
    );
  }

  @override
  void assignWidgets() async{
    widgets.clear();
    await parseJson(widgets, getPageIdentifier());
    setState(() {});

    try{
      treePrice.value=valueArray.where((element) => element['key']=='TreePrice').toList()[0]['value'];

    }catch(E){
      treePrice.value=0.0;
    }
    treeCalc(1);
  }

  @override
  String getPageIdentifier(){
    return General.donateIdentifier;
  }

  void treeCalc(treeCount){
    totalTrees.value=parseInt(treeCount);
    if(totalTrees.value==1){
      selectedTreeCount=0;
    }
    else if(totalTrees.value==10){
      selectedTreeCount=1;
    }
    else if(totalTrees.value==100){
      selectedTreeCount=2;
    }
    else{
      selectedTreeCount=-1;
    }
    if(isRupees.value){
      totalCost.value=Calculation().mul(totalTrees.value, treePrice.value);
    }
    else{
      totalCost.value=parseDouble(priceToDonate.text);
    }

    setState(() {});
  }

  void priceToTree(a){
    customNoofTrees.clear();
    double price=parseDouble(a);
    int treeCount=0;
    if(price>0 && price >=treePrice.value){
      treeCount=Calculation().div(price, treePrice.value).toInt();
    }
    treeCalc(treeCount);
  }
}


class DonarInfo extends StatelessWidget with HappyExtensionHelper{

  Function(dynamic) onDonateCb;
  DonarInfo({Key? key,required this.onDonateCb}) : super(key: key){
    widgets.value=[name,email,phoneNo];
  }



  AddNewLabelTextField name=AddNewLabelTextField(
    dataname: "DonorName",
    labelText: "Name",
    required: true,
    regExp: null,
    onChange: (v){},
    onEditComplete: (){
      FocusScope.of(Get.context!).unfocus();
    },
  );
  AddNewLabelTextField email=AddNewLabelTextField(
    dataname: "DonorEmailId",
    labelText: "Email",
    required: true,
    onChange: (v){},
    onEditComplete: (){
      FocusScope.of(Get.context!).unfocus();
    },
  );
  AddNewLabelTextField phoneNo=AddNewLabelTextField(
    dataname: "DonorContactNumber",
    labelText: "Mobile Number",
    required: true,
    regExp: MyConstants.digitRegEx,
    textInputType: TextInputType.number,
    textLength: MyConstants.phoneNoLength,
    onChange: (v){},
    onEditComplete: (){
      FocusScope.of(Get.context!).unfocus();
    },
  );


  var widgets=[].obs;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorUtil.bgColor,
        body: Column(
          children: [
            CustomAppBar(
              title: "Donor Detail",
            ),
            widgets[0]??Container(),
            widgets[1]??Container(),
            widgets[2]??Container(),
            const Spacer(),
            DoneBtn(
              title: "Donate",
              onDone:onDonate,
            ),
            const SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }

  void onDonate() async{
    List<ParameterModel> params=await getFrmCollection(widgets.value);
    if(params.isNotEmpty){
      onDonateCb(params);
    }
  }

  void clearFrm(){
    clearAll(widgets.value);
  }
}

