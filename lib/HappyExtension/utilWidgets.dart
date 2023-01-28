import '../HappyExtension/extensionHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/colorUtil.dart';
import '../utils/sizeLocal.dart';

TextStyle errorTS=TextStyle(fontFamily: 'RR',fontSize: 14,color: Color(0xFFE34343));

class HiddenController extends StatelessWidget {
  bool hasInput;
  String dataname;
 // var value="".obs;

  HiddenController({this.hasInput=true,required this.dataname});

  Rxn value=Rxn();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0,
      child: Obx(() => Text("${value.value}")),
    );
  }

  getType(){
    return 'hidden';
  }
  getValue(){
    return value.value;
  }
  setValue(var val){
    value.value=val;
  }
  String getDataName(){
    return dataname;
  }
}

Color addNewTextFieldText=Color(0xFF787878);
Color disableColor=Color(0xFFe8e8e8);
Color addNewTextFieldBorder=Color(0xFFCDCDCD);
const Color addNewTextFieldFocusBorder=Color(0xFF6B6B6B);
class AddNewLabelTextField extends StatelessWidget {
  bool isEnabled;
  String? labelText;
  double scrollPadding;
  TextInputType textInputType;
  Widget? prefixIcon;
  Widget? suffixIcon;
  Function(String)? onChange;
  VoidCallback? ontap;
  TextInputFormatter? textInputFormatter;
  VoidCallback? onEditComplete;
  bool isObscure;
  int? maxlines;
  int? textLength;
  String regExp;

  bool hasInput;
  bool required;
  String dataname;
  late TextEditingController textEditingController;

  AddNewLabelTextField({this.labelText,this.scrollPadding=270.0,this.textInputType:TextInputType.text,
    this.prefixIcon,this.ontap,this.onChange,this.textInputFormatter,this.isEnabled=true,this.suffixIcon,this.onEditComplete,
    this.isObscure=false,this.maxlines=1,this.textLength=null,this.regExp='[A-Za-z0-9@.,]',this.hasInput=true,this.required=false,required this.dataname}){
    textEditingController= new TextEditingController();
  }
  var isValid=true.obs;
  var errorText="* Required".obs;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  maxlines!=null? Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left:15,right:15,top:10,),
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.transparent
          ),
          child:  TextFormField(
            enabled: isEnabled,
            onTap: ontap,
            obscureText: isObscure,
            obscuringCharacter: '*',
            scrollPadding: EdgeInsets.only(bottom: scrollPadding),
            style:  TextStyle(fontFamily: 'RR',fontSize: 16,color:ColorUtil.text3,letterSpacing: 0.2),
            controller: textEditingController,
            cursorColor:ColorUtil.text4,
            decoration: InputDecoration(
                fillColor:isEnabled?Colors.white:disableColor,
                filled: true,
                labelStyle: TextStyle(fontFamily: 'RR',fontSize: 16,color: ColorUtil.text3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  borderSide: BorderSide(
                    width: 0.2,
                    color: ColorUtil.text4,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  borderSide: BorderSide(
                    width: 0.2,
                    color: ColorUtil.text4,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  borderSide: BorderSide(
                    width: 0.2,
                    color:ColorUtil.primary,
                  ),
                ),
                labelText: labelText,
                contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
            ),
            maxLines: maxlines,
            keyboardType: textInputType,
            textInputAction: TextInputAction.done,
            // inputFormatters:  <TextInputFormatter>[
            //
            //   //textInputFormatter
            // ],

            inputFormatters: [
              LengthLimitingTextInputFormatter(textLength),
              FilteringTextInputFormatter.allow(RegExp(regExp)),
            ],
            onChanged: (v){
              onChange!(v);
            },
            onEditingComplete: (){
              onEditComplete!();
            },
          ),
        ),
        Obx(
                ()=>isValid.value?Container():Container(
                margin:  EdgeInsets.only(left:20,right:20,top:15,),
                child: Text(errorText.value,style: errorTS,)
            )
        ),
      ],
    ):
    Container(

      margin: EdgeInsets.only(left:20,right:20,top:15,),
      //    height: 50,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.transparent
      ),
      child:  TextFormField(
        enabled: isEnabled,
        onTap: ontap,
        obscureText: isObscure,
        obscuringCharacter: '*',
        scrollPadding: EdgeInsets.only(bottom: scrollPadding),
        style:  TextStyle(fontFamily: 'RR',fontSize: 15,color:addNewTextFieldText,letterSpacing: 0.2),
        controller: textEditingController,
        decoration: InputDecoration(
            fillColor:isEnabled?Colors.white: Color(0xFFe8e8e8),
            filled: true,
            labelStyle: TextStyle(fontFamily: 'RL',fontSize: 15,color: addNewTextFieldText.withOpacity(0.9)),
            border:  OutlineInputBorder(
                borderSide: BorderSide(color: addNewTextFieldBorder)
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: addNewTextFieldBorder)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color:addNewTextFieldFocusBorder)
            ),
            labelText: labelText,
            contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon



        ),
        maxLines: maxlines,
        keyboardType: textInputType,
        textInputAction: TextInputAction.done,

        onChanged: (v){
          onChange!(v);
        },
        onEditingComplete: (){

          onEditComplete!();
        },
      ),

    );
  }

  getType(){
    return 'inputTextField';
  }

  getValue(){
    return textEditingController.text;
  }

  setValue(var value){
    textEditingController.text=value.toString();
  }

  String getDataName(){
    return dataname;
  }

  void clearValues(){
    textEditingController.text="";
  }

  validate(){
    requiredCheck();
    return isValid.value;
  }
  requiredCheck(){
  if(textEditingController.text.isEmpty){
    isValid.value=false;
    errorText.value="* Required";
  }
  else{
    isValid.value=true;
  }
  // return isValid.value;
}
  minLengthCheck(dynamic min){
  if(textEditingController.text.isEmpty){
    isValid.value=false;
    errorText.value="* Minimum Length is $min";
  }
  else if(textEditingController.text.length<int.parse(min.toString())){
    isValid.value=false;
    errorText.value="* Minimum Length is $min";

  }
  else{
    isValid.value=true;
  }
  //  return isValid.value;
}
  maxLengthCheck(dynamic max){
  if(textEditingController.text.isEmpty){
    isValid.value=false;
    errorText.value="* Maximum Length is $max";
  }
  else if(textEditingController.text.length>int.parse(max.toString())){
    isValid.value=false;
    errorText.value="* Maximum Length is $max";

  }
  else{
    isValid.value=true;
  }
  // return isValid.value;
}
  emailValidation(){

  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern as String);
  if(textEditingController.text.isEmpty){
    isValid.value=true;
    return;
  }
  if (!regex.hasMatch(textEditingController.text)) {
    isValid.value=false;
    errorText.value='* Email format is invalid';
  }
  else {
    isValid.value=true;
  }
  // return isValid.value;
}
}

class HE_Text extends StatelessWidget implements ExtensionCallback{
  bool hasInput;
  bool required;
  String dataname;
  String content;
  TextStyle contentTextStyle;
  TextOverflow? textOverFlow;
  HE_Text({this.hasInput=false,this.required=false,required this.dataname,this.content="Hello",required this.contentTextStyle,this.textOverFlow}){
    text.value=content;
    textStyle.value=contentTextStyle;
  }
  Rxn text=Rxn();
  Rxn<TextStyle> textStyle=Rxn<TextStyle>();
  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=>Text("${text.value}",style: textStyle.value,overflow: textOverFlow,)
    );
  }

  @override
  void clearValues() {
    text.value="";
  }

  @override
  String getDataName() {
    return dataname;
  }

  @override
  String getType() {
    return 'HE_Text';
  }

  @override
  getValue() {
    return text;
  }

  @override
  setValue(value) {
    text.value=value.toString();
  }

  @override
  bool validate() {
    return text.value.isNotEmpty;
  }
}

class HE_WrapText extends StatelessWidget implements ExtensionCallback{
  bool hasInput;
  bool required;
  String dataname;
  String content;
  TextStyle contentTextStyle;
  String content2;
  TextStyle contentTextStyle2;

  HE_WrapText({this.hasInput=false,this.required=false,required this.dataname,this.content="Hello",required this.contentTextStyle,
    this.content2="Hello",required this.contentTextStyle2}){
    text.value=content;
    text2.value=content2;
    textStyle.value=contentTextStyle;
    textStyle2.value=contentTextStyle2;
  }
  Rxn text=Rxn();
  Rxn text2=Rxn();
  Rxn<TextStyle> textStyle=Rxn<TextStyle>();
  Rxn<TextStyle> textStyle2=Rxn<TextStyle>();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 5.0,
      children: [
        Obx(
              ()=> Text(
            "${text.value??""}",
            style: textStyle.value,

          ),
        ),
        Obx(
              ()=> Text(
            "${text2.value??""}",
            style: textStyle2.value,
          ),
        ),
      ],
    );
  }

  @override
  void clearValues() {
    // TODO: implement clearValues
  }

  @override
  String getDataName() {
    return dataname;
  }

  @override
  String getType() {
    return 'HE_WrapText';
  }

  @override
  getValue() {
    // TODO: implement getValue
    throw UnimplementedError();
  }

  @override
  setValue(value) {
    print(value);
    if(value.runtimeType.toString()=="_InternalLinkedHashMap<String, dynamic>" || value.runtimeType.toString()=="_InternalLinkedHashMap<dynamic, dynamic>" ){
      Map parsedValue=value;
      if(parsedValue.containsKey("value2")){
        text2.value=parsedValue["value2"].toString();
      }
      if(parsedValue.containsKey("style2")){
        textStyle2.value=parsedValue["style2"];
      }
      if(parsedValue.containsKey("value1")){
        text.value=parsedValue["value1"].toString();
      }
      if(parsedValue.containsKey("style1")){
        textStyle.value=parsedValue["style1"];
      }
    }
  }

  @override
  bool validate() {
    // TODO: implement validate
    throw UnimplementedError();
  }
}

















//Json Parsing Functions

TextStyle? parseTextStyle(var textStyle) {
  var map=textStyle;
  if (map == null) {
    return null;
  }
  // else if(textStyle.runtimeType== String){
  //   map=myCallback.getWidgetMapFromTemplate(textStyle);
  // }

  //TODO: more properties need to be implemented, such as decorationColor, decorationStyle, wordSpacing and so on.
  String? color = map['color'];
  String? debugLabel = map['debugLabel'];
  String? decoration = map['decoration'];
  String? decorationColor = map['decorationColor'];
  String? shadowColor = map['shadowColor'];
  String? fontFamily = map['fontFamily'];
  double? fontSize = map['fontSize']?.toDouble();
  String? fontWeight = map['fontWeight'];
  FontStyle fontStyle =
  'italic' == map['fontStyle'] ? FontStyle.italic : FontStyle.normal;

  return TextStyle(
    color: parseHexColor(color),
    debugLabel: debugLabel,
    decoration: parseTextDecoration(decoration),
    decorationColor: parseHexColor(decorationColor),
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontStyle: fontStyle,
    shadows:map.containsKey('shadowColor')? [
      Shadow(
          color: parseHexColor(shadowColor)!,
          offset: Offset(0, map['offsetDy'])
      )
    ]:null,
    //   fontWeight: parseFontWeight(fontWeight),
  );
}
Color? parseHexColor(String? hexColorString) {
  if (hexColorString == null) {
    return Colors.transparent;
  }
  if(hexColorString.contains("*")){
    //return myCallback.ontap({"eventName":"parseColor","color":hexColorString});
    return Colors.transparent;
  }
  else{
    hexColorString = hexColorString.toUpperCase().replaceAll("#", "");
    if(hexColorString=='red'.toUpperCase()){
      return Colors.red;
    }
    else if(hexColorString=='green'.toUpperCase()){
      return Colors.green;
    }
    else if(hexColorString=='transparent'.toUpperCase()){
      return Colors.transparent;
    }
    else if(hexColorString=='hide'.toUpperCase()){
      return null;
    }
    else{
      if (hexColorString.length == 6) {
        hexColorString = "FF" + hexColorString;
      }
      int colorInt = int.parse(hexColorString, radix: 16);
      return Color(colorInt);
    }
  }
}
TextDecoration parseTextDecoration(String? textDecorationString) {
  TextDecoration textDecoration = TextDecoration.none;
  switch (textDecorationString) {
    case "lineThrough":
      textDecoration = TextDecoration.lineThrough;
      break;
    case "overline":
      textDecoration = TextDecoration.overline;
      break;
    case "underline":
      textDecoration = TextDecoration.underline;
      break;
    case "none":
    default:
      textDecoration = TextDecoration.none;
  }
  return textDecoration;
}
