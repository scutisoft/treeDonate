
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  bool isSelect;
  VoidCallback? ontap;
  double height;
  Color selectColor;
  Color unSelectColor;
  EdgeInsets margin;
  double icnSize;
  CustomCheckBox({required this.isSelect,this.ontap,this.height=22,this.selectColor=const Color(0xFFff0022),
  this.unSelectColor=const Color(0xffE5E5ED),this.margin=const EdgeInsets.only(left: 0),this.icnSize=20.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: height,
        width: height,
        margin: margin,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color:isSelect?selectColor: unSelectColor,
        ),
        child: isSelect?Icon(Icons.done,color:Colors.white,size: icnSize,):Container(),
      ),
    );
  }
}
