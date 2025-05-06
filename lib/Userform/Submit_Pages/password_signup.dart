import 'package:matrimony_flutter/Dependecies_import/auth_dependencies.dart';
import 'package:matrimony_flutter/Userform/Submit_Pages/name_profilephoto.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordSignup extends StatefulWidget {
  const PasswordSignup({super.key});

  @override
  State<PasswordSignup> createState() => _PasswordSignupState();
}

class _PasswordSignupState extends State<PasswordSignup> {
  final GlobalKey<FormState> _formkeyOfPassword = GlobalKey();
  Future<void> signup() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await Auth().signUp(
        email: prefs.getString("emailSignup").toString(),
        password: passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => VerifyEmailAddress()),
      );
    } on FirebaseAuthException catch (e) {
      String err = '';
      switch (e.code) {
        case 'invalid-credential':
          err = 'Invalid email or password';
          break;
        default:
          err = "An unknown error occurred. Please try again.";
      }
      Get.snackbar("Error", err);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> resetPassword(email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      Get.snackbar("Send successful", "Check your email");
    } on FirebaseException catch (e) {
      Get.snackbar("Error", e.message.toString());
    } catch (e) {
      print(':::::$e::::');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  isDisplayFloatButton = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkeyOfPassword,
        child: Column(
          children: [
            SizedBox(height: 150),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListTile(
                title: Text(
                  "Password",
                  style: GoogleFonts.nunito(fontSize: 40),
                  textAlign: TextAlign.left,
                ),
                subtitle: Text(
                  "Please enter your valid password.",
                  style: GoogleFonts.nunito(fontSize: 15),
                  textAlign: TextAlign.left,
                ),
              ),
            ),

            SizedBox(height: 20),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: getTextFormField(
                controller: passwordController,
                label: "Password",
                errorMsg: passwordError,
                icon: Iconsax.password_check,
                hideText: ishidePass!,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      ishidePass = !ishidePass!;
                    });
                  },
                  icon:
                      ishidePass! ? Icon(Iconsax.eye_slash) : Icon(Iconsax.eye),
                ),
                onChanged: () {
                  if (_formkeyOfPassword.currentState?.validate() ?? true) {
                    isDisplayFloatButton = true;
                    setState(() {});
                  } else {
                    isDisplayFloatButton = false;
                    setState(() {});
                  }
                },
                validateFun: validatePassword,
              ),
            ),

SizedBox(height: 5),
            
            
          ],
        ),
      ),
      floatingActionButton:
          isDisplayFloatButton
              ? FloatingActionButton(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                onPressed: () async {
                  signup();
                },
                child: Icon(Iconsax.arrow_circle_right),
              )
              : null,
    );
  }
}
