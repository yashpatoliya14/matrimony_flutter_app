import 'package:matrimony_flutter/Authentication/AuthUsingPhoneNumber/passwordViaEmail.dart';
import 'package:matrimony_flutter/Dependecies_import/auth_dependencies.dart';
import 'package:matrimony_flutter/Userform/Submit_Pages/password_signup.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileSignup extends StatefulWidget {
  const MobileSignup({super.key});

  @override
  State<MobileSignup> createState() => _MobileSignupState();
}

class _MobileSignupState extends State<MobileSignup> {
  final GlobalKey<FormState> _formkeyOfMobileSignup = GlobalKey();

  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkeyOfMobileSignup,
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
                  if (_formkeyOfMobileSignup.currentState?.validate() ?? true) {
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
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  prefs.setString("MobileSignup", emailController.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PasswordSignup()),
                    
                  );
                },
                )
              : null,
    );
  }
}
