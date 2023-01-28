
import 'package:flutter/material.dart';
import '../utils/colorUtil.dart';
import '../utils/constants.dart';

class CustomAppBar extends StatelessWidget {
  String title;
  Widget? prefix;
  Widget? suffix;
  CustomAppBar({required this.title,this.prefix,this.suffix});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      // width: SizeConfig.screenWidth,
      child: Row(
        children: [
          prefix==null?GestureDetector(
            onTap:(){
              Navigator.pop(context);
            },
            child: Container(
                height:50,
                width:50,
                color: Colors.transparent,
                child: Icon(Icons.arrow_back_ios_new_outlined,color: ColorUtil.themeBlack,size: 20,)
            ),
          ):prefix!,
          Text(title,style:  ts18(ColorUtil.primaryTextColor2),),
          Spacer(),
          suffix??Container()
        ],
      ),
    );
  }
}

class ArrowBack extends StatelessWidget {

  VoidCallback? onTap;
  double height;
  double? imageheight;
  Color iconColor;
  ArrowBack({this.onTap,this.height=50,this.imageheight,this.iconColor=Colors.white});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
          height: 50,
          width: 50 ,
          color: Colors.transparent,
          child: Center(
            child: Icon(Icons.arrow_back_ios_outlined,color: iconColor,size: 20,),
          )
      ),
    );
  }
}