import 'dart:developer';
import '../utils/colorUtil.dart';
import 'package:flutter/material.dart';

parseDouble(var value){
  try{
    return double.parse(value.toString());
  }catch(e){}
  return 0.0;
}

void console(var content){
  log(content.toString());
}
enum PayStatus{
  payStatus,
  pay,
  paid,
  partiallyPaid,
  approved,
  rejected,
  completed,
  partialApproved,
  pending
}
Color getPaymentStsClr(int id){
  if(id==PayStatus.pay.index){
    return ColorUtil.payClr;
  }
  else if(id==PayStatus.paid.index){
    return ColorUtil.paidClr;
  }
  else if(id==PayStatus.partiallyPaid.index){
    return ColorUtil.partiallyPaidClr;
  }
  else if(id==PayStatus.approved.index){
    return ColorUtil.approvedClr;
  }
  else if(id==PayStatus.rejected.index){
    return ColorUtil.rejectClr;
  }
  else if(id==PayStatus.completed.index){
    return ColorUtil.paidClr;
  }
  else if(id==PayStatus.partialApproved.index){
    return ColorUtil.partiallyPaidClr;
  }
  else if(id==PayStatus.pending.index){
    return ColorUtil.partiallyPaidClr;
  }
  return ColorUtil.payClr;
}

