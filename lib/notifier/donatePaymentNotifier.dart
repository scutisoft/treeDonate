import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treedonate/utils/constants.dart';
import 'package:treedonate/widgets/searchDropdown/search2.dart';

import '../api/ApiManager.dart';
import '../api/apiUtils.dart';
import '../model/parameterMode.dart';
import '../pages/donateTree/paymentRedirect.dart';
import '../utils/utils.dart';
import '../widgets/alertDialog.dart';

String outputJson="";
String paymentJson="";
String donationAmt="";
void checkPaymentStatusFromRedirectUrl(String url,{String plinkId="",VoidCallback? voidCallback}) async{
  //triggerLoader();
  Map queryParam={};
  queryParam = getParamsFromUrl(url);
  console("queryParam $queryParam");

  String paymentId="";
  String paymentLinkId="";
  String status="";
  bool isProceed=false;
  if(queryParam.isEmpty){
    paymentLinkId=plinkId;
    status="Cancelled";
    List<ParameterModel> params= await getParameterEssential();
    params.add(ParameterModel(Key: "plinkid", Type: "String", Value: plinkId));
    await ApiManager().PostCall('/api/PaymentApi/CancelPaymentLink', params).then((response){
      console("CancelPaymentLink $response");
      isProceed=response[0];
      if(response[0]){
        paymentJson=response[1];
      }
    });
  }
  else{
    if(MyConstants.paymentGateway==PaymentGateway.razorpay){
      paymentId=queryParam['razorpay_payment_id'];
      paymentLinkId=queryParam['razorpay_payment_link_id'];
      status=queryParam['razorpay_payment_link_status'];
    }
    isProceed=true;
  }

  statusAlert(status, paymentLinkId, donationAmt, DateTime.now().toString());
  if(voidCallback!=null){
    voidCallback();
  }
  if(isProceed){
   updateOutputPaymentJson(outputJson, paymentJson, status);
  }
}

void generatePaymentLink(List<ParameterModel> params,{VoidCallback? onPageClose}) async{
  params.addAll(await getParameterEssential());
  params.add(ParameterModel(Key: "SpName", Type: "string", Value: "USP_Donor_InsertDonorDetails"));
  console(jsonEncode(params));
/*  await ApiManager().GetInvoke(params).then((response){
    if(response[0]){
      console("generatePaymentLink ${response}");
     *//* var parsed=jsonDecode(response[1]);
      console("generatePaymentLink ${ parsed['Table'][0]['InputJson']}");*//*
    }
  });
  return;*/
  await ApiManager().PostCall('/api/PaymentApi/GeneratePaymentInputJson', params).then((response){
    if(response[0]){
      console("generatePaymentLink ${response}");
      outputJson=response[1];
      var parsed=jsonDecode(response[1]);
      Get.to(PaymentRedirecting(
        url: parsed['short_url'],
        id: parsed['id'],
        paymentResponse: (url,id){
        console("paymentResponse $url");
        checkPaymentStatusFromRedirectUrl(url,plinkId: id,voidCallback: onPageClose);
      },))!.then((value){  });

    }
  });
}

statusAlert(String status,String orderId,String amount,String date){
  CustomAlert(
      callback: (){
        Get.back();
      }
  ).paymentAlert(status.toLowerCase()=='paid', orderId, amount, date);
  //2022-06-07T13:01:29+05:30
  //order_1659042AEuVS3IMiB1cRA10rGON2CZMqX
}

void getPaymentStatusByPLinkId(plinkId,Function(Map updatedData) cb) async{
  if(checkNullEmpty(plinkId)){
    return;
  }
  List<ParameterModel> params= [];
  params.add(ParameterModel(Key: "plinkid", Type: "String", Value: plinkId));
  await ApiManager().PostCall('/api/PaymentApi/GetPaymentLinkByPLinkId', params).then((response){
   // console("getPaymentStatusByPLinkId $response");
    if(response[0]){
      var parsed=jsonDecode(response[1]);
      String status=parsed['status'];
      cb({"PaymentStatus":status});
      updateOutputPaymentJson('',response[1],status);
    }
  });
}

void updateOutputPaymentJson(outputJson1,paymentJson1,status1) async{
  List<ParameterModel> params= await getParameterEssential();
  params.add(ParameterModel(Key: "OutputJson", Type: "String", Value: outputJson1));
  params.add(ParameterModel(Key: "PaymentJson", Type: "String", Value: paymentJson1));
  params.add(ParameterModel(Key: "PaymentStatus", Type: "String", Value: status1));
  params.add(ParameterModel(Key: "SpName", Type: "String", Value: "USP_DonorPayment_UpdateDonationDetails"));

  await ApiManager().GetInvoke(params).then((response){
    console("USP_DonorPayment_UpdateDonationDetails $response");
  });
}