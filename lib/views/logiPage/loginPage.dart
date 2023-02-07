// ignore_for_file: override_on_non_overriding_member, unused_field

import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/globalWidgets/button.dart';
import 'package:base_project_flutter/main.dart';
import 'package:base_project_flutter/views/DigitCode/DigitCode.dart';
import 'package:base_project_flutter/views/accountNotExist/accountExist.dart';
import 'package:base_project_flutter/views/loginPassCodePages/mobileNumber.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:lottie/lottie.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../api_services/userApi.dart';
import '../../constants/constants.dart';
import 'package:sizer/sizer.dart';

import '../../constants/imageConstant.dart';
import '../../responsive.dart';
import '../accountNotExist/accountNotExist.dart';
import '../passwordRecovery/passwordRecovery.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      color: tBlack.withOpacity(0.4),
      // child: Image.asset(
      //   loading.LOADING,
      //   width: 50.w,
      // ),
      child: Lottie.asset(
        Loading.LOADING,
        width: 50.w,
      ),
    );
  }
}

class LoginMobileNumber1 extends StatefulWidget {
  const LoginMobileNumber1({Key? key}) : super(key: key);

  @override
  State<LoginMobileNumber1> createState() => _LoginMobileNumberState();
}

class _LoginMobileNumberState extends State<LoginMobileNumber1> {
  String dropdownValue = '+44';
  @override
  final TextEditingController _mobileNumberController = TextEditingController();

  final _formKey = new GlobalKey<FormState>();
  bool loading = false;

  startLoader(value) {
    setState(() {
      loading = value;
    });
  }

  var btnColor = tIndicatorColor;
  var selectedvalue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = false;
  }

  x() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      startLoader(true);
      var userName = dropdownValue + _mobileNumberController.text;
      var checkUser = await UserAPI().checkUser(context, userName);
      print('checkUser>>>>>>>>>');
      print(checkUser);
      if (checkUser != null) {
        if (checkUser['status'] == 'OK' &&
            checkUser['user_registered'] == true) {
          var res = await UserAPI.sendOtp(context, userName);
          print(res);
          print(userName);
          if (res != null && res['status'] == 'OK') {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setString("userName", userName);
            if (dropdownValue == '+44') {
              sharedPreferences.setString('countryCode', "GB");
            } else if (dropdownValue == '+91') {
              sharedPreferences.setString('countryCode', 'GB');
            }

            // sharedPreferences.setString(
            //     "sessionId", res['details']['Details']);
            startLoader(false);
            setState(() {
              loading = false;
            });
            Twl.navigateTo(
                context,
                DigitCode(
                  index: null,
                ));

            await analytics.logEvent(
              name: "mobile_login",
              parameters: {
                "number": userName,
                "button_clicked": true,
              },
            );

            Segment.track(
              eventName: 'mobile_login',
              properties: {"number": userName, "clicked": true},
            );

            mixpanel.track('mobile_login',
                properties: {"number": userName, "clicked": true});

            await logEvent("mobile_login", {
              "number": userName,
              'clicked': true,
            });

            // Twl.navigateTo(context, EnterYourPasscode());
          } else {
            setState(() {
              loading = false;
            });
            startLoader(false);
          }
        } else if (checkUser['user_registered'] == false) {
          startLoader(false);
          Twl.navigateTo(context, AccountNotExist());
        }
      } else {
        startLoader(false);
      }
      // if (_userMobileNumberController
      //         .text.isEmpty &&
      //     _userMobileNumberController.text ==
      //         '') {
      //   stopLoading();
      //   // final snackBar = SnackBar(
      //   //   content: const Text(
      //   //       'please select country'),
      //   //   action: SnackBarAction(
      //   //     label: 'Undo',
      //   //     onPressed: () {
      //   //       // Some code to undo the change.
      //   //     },
      //   //   ),
      //   // );

      //   // ScaffoldMessenger.of(context)
      //   //     .showSnackBar(snackBar);
      // } else if (_userMobileNumberController
      //         .text.length <
      //     10) {
      //   stopLoading();
      //   // final snackBar = SnackBar(
      //   //   content: const Text(
      //   //       'number must be 10 digits'),
      //   //   action: SnackBarAction(
      //   //     label: 'Undo',
      //   //     onPressed: () {
      //   //       // Some code to undo the change.
      //   //     },
      //   //   ),
      //   // );

      //   // ScaffoldMessenger.of(context)
      //   //     .showSnackBar(snackBar);
      // } else {
      //   //startLoading();
      //   // setState(() {
      //   //   isLoading = true;
      //   // });
      //   loader(true);
      //   var userName = dropdownValue +
      //       _userMobileNumberController.text;
      //   var checkUser = await UserAPI()
      //       .checkUser(context, userName);
      //   print('checkUser>>>>>>>>>');
      //   print(checkUser);
      //   if (checkUser != null &&
      //       checkUser['status'] == 'OK' &&
      //       checkUser['user_registered'] ==
      //           true) {
      //     var res = await UserAPI.sendOtp(
      //         context, userName);
      //     print(res);
      //     print(userName);
      //     if (res != null &&
      //         res['status'] == 'OK') {
      //       SharedPreferences
      //           sharedPreferences =
      //           await SharedPreferences
      //               .getInstance();
      //       sharedPreferences.setString(
      //           "userName", userName);
      //       if (dropdownValue == '+44') {
      //         sharedPreferences.setString(
      //             'countryCode', "GB");
      //       } else if (dropdownValue == '+91') {
      //         sharedPreferences.setString(
      //             'countryCode', 'GB');
      //       }

      //       // sharedPreferences.setString(
      //       //     "sessionId", res['details']['Details']);
      //       loader(false);
      //       setState(() {
      //         isLoading = false;
      //       });
      //       Twl.navigateTo(
      //           context,
      //           DigitCode(
      //             index: null,
      //           ));
      //       // Twl.navigateTo(context, EnterYourPasscode());
      //     } else {
      //       setState(() {
      //         isLoading = false;
      //       });
      //       loader(false);
      //     }
      //   } else if (checkUser[
      //           'user_registered'] ==
      //       false) {
      //     loader(false);
      //     Twl.navigateTo(
      //         context, AccountNotExist());
      //   }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: tWhite,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: tWhite,
              leading: GestureDetector(
                // change the back button shadow
                onTap: () {
                  Twl.navigateBack(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: selectedvalue == 1 ? btnColor : tWhite,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(
                      Images.NAVBACK,
                      scale: 4,
                    ),
                  ),
                ),
              ),
            ),
            body: Form(
              key: _formKey,
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 0, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Log back in",
                                  style: TextStyle(
                                      color: tPrimaryColor,
                                      fontFamily: 'Signika',
                                      fontSize: isTab(context) ? 18.sp : 21.sp,
                                      fontWeight: FontWeight.w700)),
                              SizedBox(height: 2.h),
                              Text(
                                  "Enter your phone number to login to Metfolio",
                                  style: TextStyle(
                                      color: tSecondaryColor,
                                      fontSize: isTab(context) ? 10.sp : 12.sp,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(height: 6.h),
                              Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      height: 45,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          color: tlightGrayblue),
                                      child: DropdownButton<String>(
                                        value: dropdownValue,
                                        items: <String>["+91", "+44"]
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: tSecondaryColor,
                                                fontSize: isTab(context)
                                                    ? 13.sp
                                                    : 16.sp,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        underline: Container(
                                            color: tTextformfieldColor),
                                        onChanged: (String? newValue) async {
                                          SharedPreferences sharedPreferences =
                                              await SharedPreferences
                                                  .getInstance();

                                          setState(() {
                                            sharedPreferences.setString(
                                                'countryCode', newValue!);
                                            dropdownValue = newValue;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: Container(
                                          height: 45,
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "";
                                              } else if (value.length != 10
                                                  // value.length <= 9 &&
                                                  //   value.length <= 11
                                                  ) {
                                                return "";
                                              } else {
                                                return null;
                                              }
                                            },
                                            onChanged: (v) {
                                              _formKey.currentState!.validate();
                                            },
                                            controller: _mobileNumberController,
                                            //_phoneNumberController,
                                            keyboardType: TextInputType.phone,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                  10)
                                            ],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: tSecondaryColor,
                                                fontSize: isTab(context)
                                                    ? 13.sp
                                                    : 16.sp),
                                            decoration: InputDecoration(
                                              // prefix: Text('+91 ',style: TextStyle(color: tBlack),),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 1,
                                                ),
                                              ),
                                              hintStyle: TextStyle(
                                                  fontSize: isTab(context)
                                                      ? 10.sp
                                                      : 14.sp),
                                              // hintText: 'Enter Your Mobile Number',
                                              fillColor: tlightGrayblue,
                                              errorStyle: TextStyle(height: 0),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 2),
                                              filled: true,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                borderSide: BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 1.h),
                        child: Container(
                          height: 40,
                          width: 230,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: tPrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            child: Text('Continue',
                                style: TextStyle(
                                  color: tBlue,
                                )),
                            onPressed: x,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (loading)
          Center(
            child: Container(
              color: tBlack.withOpacity(0.3),
              // padding:
              //     EdgeInsets.only(top: 100),
              height: 100.h,
              width: 100.w,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: tPrimaryColor,
              ),
            ),
          ),
      ],
    );
  }
}
