
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:treedonate/utils/colorUtil.dart';
import '../../HappyExtension/extensionHelper.dart';
import '../../HappyExtension/utilWidgets.dart';
import '../../utils/constants.dart';
import '../../utils/general.dart';
import '../../utils/sizeLocal.dart';
import '../navHomeScreen.dart';




class FilterItems extends StatefulWidget {
  const FilterItems({Key? key}) : super(key: key);

  @override
  _FilterItemsState createState() => _FilterItemsState();
}

class _FilterItemsState extends State<FilterItems>with HappyExtensionHelper  implements HappyExtensionHelperCallback {
  List<Widget> widgets=[];
  @override
  void initState(){
    assignWidgets();
    super.initState();
  }

  var node;
  @override
  late  double width,height,width2,height2;
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    height2=height-16;
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                height: height,
                width: width,
                padding: EdgeInsets.only(left: 15.0,right: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Container(
                      height: 70,
                      child: Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(0xffEFF1F8),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Color(0xffD4D5D7))
                              ),
                              child: IconButton(onPressed: (){
                                Get.back();
                              },
                                icon: Icon(Icons.arrow_back_ios_sharp,color: ColorUtil.primary,size: 20,),),
                            ),
                            Container(
                              width: SizeConfig.screenWidth!*0.65,
                              alignment: Alignment.center,
                              child: Text('Filter',style: TextStyle(fontFamily: 'RM',fontSize: 18,color: Colors.black,letterSpacing: 0.1),),
                            ),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text('SELECT Status',style: TextStyle(fontFamily: 'RB',fontSize: 16,color: Color(0xff000000)),),
                    SizedBox(height: 20,),
                    Wrap(
                      spacing: 25,
                      runSpacing: 25,
                      alignment: WrapAlignment.center,
                      // runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        StatustBtn('Reject'),
                        StatustBtn('Accept'),
                        StatustBtn('Pending'),
                      ],
                    ),
                    SizedBox(height: 20,),
                    widgets[0],
                    widgets[1],
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child:  Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.all(15.0),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: ColorUtil.primary,
                  ),
                  child:Center(child: Text('Apply',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xffffffff),fontFamily:'RR'), )) ,
                ),
              ),
            ],
          ),
        )
    );
  }
  @override
  void assignWidgets() async{
    widgets.add(AddNewLabelTextField(
      dataname: 'Name',
      hasInput: true,
      required: true,
      labelText: "From Date",
      suffixIcon: Icon(Icons.date_range_outlined,color: ColorUtil.primary,),
      regExp: MyConstants.alphaSpaceRegEx,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));

    widgets.add(AddNewLabelTextField(
      dataname: 'Name',
      hasInput: true,
      required: true,
      suffixIcon: Icon(Icons.date_range_outlined,color: ColorUtil.primary,),
      labelText: "To Date",
      regExp: MyConstants.alphaSpaceRegEx,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));

    setState(() {});
    await parseJson(widgets, General.addVolunteerIdentifier);
  }
}
Widget StatustBtn (String Status){
  return Container(
    width:90,
    height: 40,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: ColorUtil.primary,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: ColorUtil.primary)
    ),
    child: Text(Status,style: TextStyle(fontFamily: 'RM',fontSize: 14,color: Color(0xffffffff)),),
  );

}