import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:matrimony_flutter/User_Display/app_bar.dart';
import 'package:matrimony_flutter/Userform/form_methods.dart';
import 'package:matrimony_flutter/Userform/form_utils.dart';
import 'package:get/get.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  Future<void> resetPassword(email)
  async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseException catch(e){
      Get.snackbar("Error", e.message.toString());
    }catch (e){
      print(':::::${e}::::');
    }
  }
    TextEditingController controllerEmail = TextEditingController();
    GlobalKey<FormState> _formkeyForForgot = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.08,
        ),
        child: getAppBar(context, name: "Reset Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkeyForForgot,
          child: SingleChildScrollView(
            child: Column(
              children: [
                getTextFormField(
                  label: "Email",
                  controller: controllerEmail,
                  icon: Iconsax.message,
                  validateFun: validateEmail,
                  errorMsg: emailError,
                  keyboardType: TextInputType.emailAddress

                ),
                SizedBox(
                  width: 20,
                  height: 20,
                ),
                ElevatedButton(onPressed: (){
                    if(_formkeyForForgot.currentState!.validate()){
                      resetPassword(controllerEmail.text);
                    }
                }, child: Text("Reset"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
