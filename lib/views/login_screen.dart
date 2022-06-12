


import 'package:apni_mandi_admin/controllers/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/color_manager.dart';
import '../constants/helper.dart';
import '../constants/text_helper.dart';
import '../constants/values_manager.dart';
import '../globalWidgets/action_button.dart';
import '../globalWidgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double height = Get.height;
  double width = Get.width;
  final LoginController _loginController = Get.put(LoginController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSpaceVertical(height * 0.09),
              Center(
                child: textStyle7(text: 'Welcome Back'),
              ),
              buildSpaceVertical(height * 0.02),
              Center(child: Image.asset("assets/logo.png", height: height * 0.25, width: width * 0.5)),
              buildSpaceVertical(height * 0.04),

              CustomTextField(
                controller: emailController,
                hintName: "ENTER EMAIL",
              ),
              buildSpaceVertical(height * 0.03),

              CustomTextField(
                controller: passwordController,
                hintName: "ENTER PASSWORD",
                isPass: true,
              ),

              buildSpaceVertical(height * 0.06),
              InkWell(
                onTap: () {
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState!.save();
                    if(emailController.text == "arrtiAdmin@gmail.com" && passwordController.text == "12345678"){
                      _loginController.login(emailController.text.trim(), passwordController.text.trim());
                    }else{
                      errorToast("Error", "You are not Admin");
                    }

                  }
                },
                child: Obx(() {
                  return  _loginController.isLoading.isTrue ?
                  Center(
                    child: Container(
                        height: height * 0.06,
                        width: width * 0.43,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s26),
                          color: ColorManager.primaryColor,
                        ),
                        child: const Center(child: CupertinoActivityIndicator())),
                  )
                      :  Center(child: actionButton('LOGIN', context));
                }),
              ),

              buildSpaceVertical(height * 0.1),


            ],
          ),
        ),
      ),
    );
  }
}
