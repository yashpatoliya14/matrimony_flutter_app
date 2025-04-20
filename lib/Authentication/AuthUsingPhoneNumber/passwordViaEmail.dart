import 'package:matrimony_flutter/Dependecies_import/auth_dependencies.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordViaEmail extends StatefulWidget {
  const PasswordViaEmail({super.key});

  @override
  State<PasswordViaEmail> createState() => _PasswordViaEmailState();
}

class _PasswordViaEmailState extends State<PasswordViaEmail> {
  bool _isDisplayButton = false;
  final GlobalKey<FormState> _formkeyOfPassword = GlobalKey();
  Future<void> signIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await Auth().signIn(
        email: prefs.getString("email").toString(),
        password: passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
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
                    _isDisplayButton = true;
                    setState(() {});
                  } else {
                    _isDisplayButton = false;
                    setState(() {});
                  }
                },
                validateFun: validatePassword,
              ),
            ),

SizedBox(height: 5),
            GestureDetector(
              onTap: () async {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => PasswordViaEmail()),
                // );
                SharedPreferences prefs =await SharedPreferences.getInstance();
                await resetPassword(prefs.getString("email"));
              },
              child: Text(
                "forgot a password ?",
                style: GoogleFonts.nunito(),
                textAlign: TextAlign.center,
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
                  signIn();
                },
                child: Icon(Iconsax.arrow_circle_right),
              )
              : null,
    );
  }
}
