
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../helper/language.dart';
import '../../utils/colorUtil.dart';
import '../../widgets/loader.dart';
import '../../widgets/logoPicker.dart';
import '../../HappyExtension/extensionHelper.dart';
import '../../HappyExtension/utilWidgets.dart';
import '../../utils/constants.dart';
import '../../utils/general.dart';
import '../../utils/sizeLocal.dart';
import '../navHomeScreen.dart';




class EditProfile extends StatefulWidget {
  Function? closeCb;
  EditProfile({super.key, this.closeCb});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>with HappyExtensionHelper  implements HappyExtensionHelperCallback {
  List<dynamic> widgets=[];
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
                child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.start,
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
                              child: Text(Language.myProfile,style: TextStyle(fontFamily:Language.mediumFF,fontSize: 18,color: Colors.black,letterSpacing: 0.1),),
                            ),

                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    widgets[4],
                    const SizedBox(height: 20,),
                    widgets[0],
                    widgets[1],
                    widgets[2],
                    const SizedBox(height: 100,),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child:  GestureDetector(
                  onTap: (){
                    sysSubmit(widgets,isEdit: true,
                      successCallback: (e){
                        if(widget.closeCb!=null){
                          widget.closeCb!(e);
                        }
                      }
                    );
                  },
                  child: Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.all(15.0),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: ColorUtil.primary,
                    ),
                    child:Center(child: Text(Language.update,style: TextStyle(fontSize: 16,color: ColorUtil.themeWhite,fontFamily:Language.regularFF), )) ,
                  ),
                ),
              ),
              ShimmerLoader(),
            ],
          ),
        )
    );
  }
  @override
  void assignWidgets() async{
    /*widgets.add(AddNewLabelTextField(
      dataname: 'UserName',
      hasInput: true,
      required: true,
      labelText: "Name",
      regExp: MyConstants.alphaSpaceRegEx,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));*/
    widgets.add(AddNewLabelTextField(
      dataname: 'Email',
      hasInput: true,
      required: true,
      labelText: Language.email,
      regExp: MyConstants.addressRegEx,
      needEmailCheck: true,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(AddNewLabelTextField(
      dataname: 'PhoneNumber',
      hasInput: true,
      required: true,
      labelText: Language.mobileNo,
      regExp: MyConstants.digitRegEx,
      textLength: MyConstants.phoneNoLength,
      needMinLengthCheck: true,
      minLength: MyConstants.phoneNoLength,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));
    widgets.add(AddNewLabelTextField(
      dataname: 'Password',
      hasInput: true,
      required: true,
      isObscure: true,
      labelText: Language.password,
      regExp: MyConstants.addressRegEx,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));

    widgets.add(HiddenController(dataname: "UserId"));
    widgets.add(SingleImagePicker(dataname: "UserImage", folder: "Image",hasInput: true,required: true,));

    setState(() {});

    widgets[2].suffixIcon= GestureDetector(
      onTap: (){
        widgets[2].isObscure=!widgets[2].isObscure;
        widgets[2].reload.value=!widgets[2].reload.value;
      },
      child: Container(
        height: 30,
        width: 30,
        alignment: Alignment.center,
        color: Colors.transparent,
        child: Icon(! widgets[2].isObscure?Icons.visibility_off_outlined:Icons.visibility_outlined,color: ColorUtil.primary,)
      ),
    );
    await parseJson(widgets, getPageIdentifier());
  }

  @override
  String getPageIdentifier(){
    return General. EditProfileViewIdentifier;
  }

}
