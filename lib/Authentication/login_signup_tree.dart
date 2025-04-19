import 'package:flutter/material.dart';
import 'package:matrimony_flutter/Dependecies_import/auth_dependencies.dart';
import 'package:matrimony_flutter/Widgets/common_buttons.dart';
export 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true;
  bool isNewUser = false;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signIn() async {
    try {
      await Auth().signIn(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      String err = '';
      switch (e.code) {
        case 'user-not-found':
          err = 'Email Address doesn\'t exist! Try Again!';
          break;
        case 'wrong-password':
          err = 'Password is incorrect';
          break;
        case 'invalid-email':
          err = "The email address is not valid.";
          break;
        case 'user-disabled':
          err = "This user account has been disabled.";
          break;
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

  Future<void> signUp() async {
    try {
      await Auth().signUp(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseException catch (e) {
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
      print(":::::::${e.toString()}::::::");
    }
  }

  final GlobalKey<FormState> _formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.08,
        ),

        child: AppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [

              //logo
              Image.asset("assets/login_signup_tree1.png", width: 100),
              SizedBox(height: 50),

              //Sign in / up to continue
              Text(
                "${isNewUser ? "Sign Up" : "Sign In"} to continue",
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),

              //continue with email button
              buildButton(
                label: "Continue with email",
                textColor: Colors.white,
                backgroundColor: Colors.purple,
              ),
              SizedBox(height: 20),

              ////continue with phone number
              buildButton(
                label: "Use phone number",
                textColor: Colors.purple,
                backgroundColor: Colors.white30,
                borderColor: Colors.black,
              ),
              SizedBox(height: 20),

              //divider ------------------------pending to seperate component
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Divider(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "or sign Up with",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Divider(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),


              // google button
              buildButton(
                label: isNewUser ? "Sign up with Google" : "Sign in with Google", 
                textColor: Colors.black,
                backgroundColor: Colors.white30,
                icon: Image.asset("assets/google_image.jpg",height: 20,),
                borderColor: Colors.black,
                onPressed: () async {
                  try{
                    await Auth().signInWithGoogle();
                  }catch(err){
                      print(err);
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
