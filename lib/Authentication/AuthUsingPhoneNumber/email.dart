import 'package:matrimony_flutter/Authentication/AuthUsingPhoneNumber/passwordViaEmail.dart';
import 'package:matrimony_flutter/Dependecies_import/auth_dependencies.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Email extends StatefulWidget {
  const Email({super.key});

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  final GlobalKey<FormState> _formkeyOfEmail = GlobalKey();

  

  bool _isDisplayButton = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkeyOfEmail,
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
                  "Please enter your valid email. We will send you a 4-digit code to verify your account.",
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
                  if (_formkeyOfEmail.currentState?.validate() ?? true) {
                    _isDisplayButton = true;
                    setState(() {});
                  } else {
                    _isDisplayButton = false;
                    setState(() {});
                  }
                },
              ),
            ),

            
          ],
        ),
      ),

      floatingActionButton:
          _isDisplayButton
              ? FloatingActionButton(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  prefs.setString("email", emailController.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PasswordViaEmail()),
                  );
                },
                child: Icon(Iconsax.arrow_circle_right),
              )
              : null,
    );
  }
}
