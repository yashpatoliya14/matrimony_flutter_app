
import 'package:firebase_auth/firebase_auth.dart';
import 'package:matrimony_flutter/Userform/Submit_Pages/name_profilephoto.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Password extends StatefulWidget {
  bool isSignin;
  Password({super.key,required this.isSignin});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
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
  Future<void> signup() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("Password", passwordController.text);
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
                validateFun: validatePassword,
              ),
            ),

SizedBox(height: 5),
            buildButton(
                label: "Save",
                textColor: Colors.white,
                backgroundColor: Colors.purple,
                icon: Icon(Iconsax.next, color: Colors.white),
                onPressed: () async {
                  if(widget.isSignin){
                    signIn();
                  }else{
                    signup();
                  }
                }
            ),
            
          ],
        ),
      ),

    );
  }
}
