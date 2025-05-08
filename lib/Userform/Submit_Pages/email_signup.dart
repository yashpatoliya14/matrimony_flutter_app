import 'dart:convert';

import 'package:matrimony_flutter/Authentication/AuthUsingPhoneNumber/passwordViaEmail.dart';
import 'package:matrimony_flutter/Dependecies_import/auth_dependencies.dart';
import 'package:matrimony_flutter/Userform/Submit_Pages/password_signup.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class EmailSignup extends StatefulWidget {
  const EmailSignup({super.key});

  @override
  State<EmailSignup> createState() => _EmailSignupState();
}

class _EmailSignupState extends State<EmailSignup> {
  final GlobalKey<FormState> _formkeyOfEmailSignup = GlobalKey();
  bool? isUserExist;
   Future<void> checkUser({required String email}) async {
     final url = Uri.parse("http://192.168.51.147:3000/api/check/$email");
     print(email);
     var res = await http.get(url);

     if(res.statusCode==200){
        Map<dynamic,dynamic> data = jsonDecode(res.body);
        print(":::::::::::::::::::::::::::::$data");
        if(data['success']==true){
            isUserExist = false;
        }else{
          isUserExist = true;
        }
     }
   }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Form(
        key: _formkeyOfEmailSignup,
        child: Column(
          children: [
            SizedBox(height: 150),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListTile(
                title: Text(
                  "My Email",
                  style: GoogleFonts.nunito(fontSize: 40),
                  textAlign: TextAlign.left,
                ),
                subtitle: Text(
                  "Please enter your valid email. We will send you a mail to verify your account.",
                  style: GoogleFonts.nunito(fontSize: 15),
                  textAlign: TextAlign.left,
                ),
              ),
            ),

            SizedBox(height: 20),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: getTextFormField(
                controller: emailController,
                icon: Iconsax.message,
                validateFun: validateEmail,
                label: "Enter your email address",
                onChanged: () {
                  if (_formkeyOfEmailSignup.currentState?.validate() ?? true) {
                    isDisplayFloatButton = true;
                    setState(() {});
                  } else {
                    isDisplayFloatButton = false;
                    setState(() {});
                  }
                },
              ),
            ),

            
          ],
        ),
      ),

      floatingActionButton:
          isDisplayFloatButton
              ? buildFloatingActionButton(
                context:context,
                onPressed: () async {
                  await checkUser(email: emailController.text);
                  if(isUserExist?? true){

                    Get.snackbar("Try Again!","Email is already registered");
                  }else{
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();

                    prefs.setString("emailSignup", emailController.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PasswordSignup()),

                    );
                  }

                },
                )
              : null,
    );
  }
}
