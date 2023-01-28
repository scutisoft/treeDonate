import 'package:flutter/material.dart';

import '../utils/colorUtil.dart';

class NavBarIcon extends StatelessWidget {
  const NavBarIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.transparent,
      ),
      padding: EdgeInsets.only(top: 2,right: 2,left: 5),
      margin: EdgeInsets.only(right: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 2,
            width: 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: ColorUtil.menu
            ),
          ),
          SizedBox(height: 3,),
          Container(
            height: 2,
            width: 13,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: ColorUtil.menu
            ),
          ),
          SizedBox(height: 3,),
          Container(
            height: 2,
            width: 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: ColorUtil.menu
            ),
          ),
        ],
      ),
    );
  }
}
