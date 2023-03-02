import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';

class PaymentRedirecting extends StatefulWidget {
  String url;
  String id;
  Function(String,String) paymentResponse;
  PaymentRedirecting({required this.url,this.id="",required this.paymentResponse});

  @override
  State<PaymentRedirecting> createState() => _PaymentRedirectingState();
}

class _PaymentRedirectingState extends State<PaymentRedirecting>  with WidgetsBindingObserver{

  //inal PaymentNotifier paymentNotifier = Get.put(PaymentNotifier());
  //final Completer<WebViewController> _controller = Completer<WebViewController>();

  late WebViewController controller;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    print("widget.url ${widget.url}");

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {

          },
          onPageStarted: (String url) {
            setState((){
              currentUrl=url;
            });
          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains(/*MyConstants.isLive?'Rad/Payment/PaymentStatus':*/'Radiant_Dev/Payment/PaymentStatus')) {
              print('blocking navigation to $request}');
              Get.back();
              widget.paymentResponse(request.url,widget.id);

              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url.replaceAll('"', '')));

    super.initState();
  }

  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  int selectedIndex=-1;
  String currentUrl="";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.confirm,
            text: 'Want to cancel this transaction',
            cancelBtnText: "Close",
            onConfirmBtnTap: (){
              Get.close(2);
              widget.paymentResponse(currentUrl,widget.id);
            }
        );
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorUtil.bgColor,
          body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            color: ColorUtil.bgColor,
            padding: EdgeInsets.only(left: 0,right: 0,bottom: 15,top: 5),
            child: Column(
              children: [
                /*Container(
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 15,),
                      GestureDetector(
                          onTap:(){
                            Get.back();
                          },
                          child:  BackArrow()
                      ),

                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         Obx(
                             ()=> Text("Pay - $rupee ${paymentNotifier.needToPayAmount}",style: ts18(text2,fontfamily: 'RM'),),
                         )
                          // SizedBox(height: 5,),
                          // Text("10-08-2022 to 10-08-2022",style: ts14(text1),),
                        ],
                      ),



                    ],
                  ),
                ),*/

                /*Flexible(
                  child: WebView(
                    initialUrl: widget.url.replaceAll('"', ''),
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    },
                    navigationDelegate: (NavigationRequest request) {

                      if (request.url.contains(MyConstants.isLive?'Rad/Payment/PaymentStatus':'Radiant_Dev/Payment/PaymentStatus')) {
                        print('blocking navigation to $request}');
                        widget.paymentResponse(request.url);
                        Get.back();
                        return NavigationDecision.prevent;
                      }

                      print('allowing navigation to $request');
                      return NavigationDecision.navigate;
                    },
                    onPageStarted: (String url) {
                      print('Page started loading: $url');
                      setState((){
                        currentUrl=url;
                      });
                    },
                    onPageFinished: (String url) {
                      print('Page finished loading: $url');
                    },
                  ),
                ),*/

                Flexible(child: WebViewWidget(controller: controller)),


                /*     LinearProgressIndicator(
                  backgroundColor: theme.withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(theme),

                ),
                SizedBox(height: 25,),
                Text("Redirecting to Payment Gateway ...",style: ts18(text3),)*/
                /*Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: br6,
                      color: monthPickerHeaderColor
                  ),
                  child: Obx(
                          ()=>Text("Pay Now $rupee ${paymentNotifier.needToPayAmount.value}",style: ts18(Colors.white,fontfamily: 'RM'),)
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}