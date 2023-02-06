
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


class EyeIcon extends StatelessWidget {
  VoidCallback? onTap;
  EyeIcon({Key? key,this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        width: 30,
        height: 30,
        alignment:Alignment.center,
        decoration: BoxDecoration(
            color: ColorUtil.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5)
        ),
        child: Icon(Icons.remove_red_eye_outlined,color: ColorUtil.primary,size: 20,),
      ),
    );
  }
}

class FilterIcon extends StatelessWidget {
  VoidCallback? onTap;
  FilterIcon({Key? key,this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorUtil.primary,
        ),
        child: Icon(Icons.filter_alt_outlined,color:ColorUtil.theme,),
      ),
    );
  }
}

class GridAddIcon extends StatelessWidget {
  VoidCallback? onTap;
  GridAddIcon({Key? key,this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorUtil.primary,
        ),
        child: Icon(Icons.add,color:ColorUtil.theme,),
      ),
    );
  }
}
