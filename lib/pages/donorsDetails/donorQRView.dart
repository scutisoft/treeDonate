
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../HappyExtension/extensionHelper.dart';
import '../../HappyExtension/utilWidgets.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/sizeLocal.dart';
import '../../widgets/customAppBar.dart';




class DonorQRView extends StatefulWidget {
  @override
  _DonorQRViewState createState() => _DonorQRViewState();
}
class _DonorQRViewState extends State<DonorQRView>with HappyExtensionHelper implements HappyExtensionHelperCallback{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Color(0XFFF3F3F3),
          resizeToAvoidBottomInset: true,
          body:Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image:DecorationImage(image: AssetImage("assets/after-scan.jpg"),fit: BoxFit.fill)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment:Alignment.centerLeft,
                      child: ArrowBack(
                        iconColor: ColorUtil.themeBlack,
                        onTap: (){
                          Get.back();
                        },
                      ),
                    ),
                      const SizedBox(height: 20,),
                      Image.asset('assets/logo.png',fit: BoxFit.cover,width: SizeConfig.screenWidth!*0.6,),
                      const SizedBox(height: 10,),
                      Container(
                        width: SizeConfig.screenWidth,
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(left:15,right: 15),
                        decoration: BoxDecoration(
                          color: ColorUtil.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                       alignment: Alignment.center,
                      child: HE_Text(dataname: "", contentTextStyle: ts18(ColorUtil.themeBlack,fontfamily: 'RM'),
                        content: "Mr.Raja k",),
                    ),
                    const SizedBox(height: 10,),
                    DonorDetail("Donor Amount","50,000",ColorUtil.themeBlack),
                    DonorDetail("Number Of Trees","250",ColorUtil.themeBlack),
                    DonorDetail("Date","03-Mar-2023",ColorUtil.themeBlack),
                    DonorDetail("Phone Number","90923-22264",ColorUtil.themeBlack),
                    DonorDetail("Email Id","balasubramaniyan@gmail.com",ColorUtil.primary),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

  @override
  void assignWidgets() {
    // TODO: implement assignWidgets
  }

  Widget DonorDetail(String title,String Value,Color Emailclr){
    return Container(
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.only(left:15,right: 15,bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 140,
                child: Text("$title",style: ts18(ColorUtil.themeBlack,fontfamily: 'RB'),)),
            Text(": ",style: ts18(Emailclr,fontfamily: 'RB'),),
         //   const Spacer(),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text("$Value",
                  style:ts18(Emailclr,fontfamily: 'RB',)
                ),
              ),
            ),
          ],
        )
    );
  }
}
