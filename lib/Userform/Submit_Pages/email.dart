import 'dart:convert';
import 'package:matrimony_flutter/Userform/Submit_Pages/password.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';
import 'package:http/http.dart' as http;



class Email extends StatefulWidget {
  bool isSignIn;
  Email({super.key,required this.isSignIn});

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  final GlobalKey<FormState> _formkeyOfEmail = GlobalKey();
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
                  if (_formkeyOfEmail.currentState?.validate() ?? true) {
                    isDisplayFloatButton = true;
                    setState(() {});
                  } else {
                    isDisplayFloatButton = false;
                    setState(() {});
                  }
                },
              ),
            ),
            buildButton(
                label: "Next",
                textColor: Colors.white,
                backgroundColor: Colors.purple,
                icon: Icon(Iconsax.next, color: Colors.white),
                onPressed: () async {
                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();

                  prefs.setString("emailSignup", emailController.text);


                  if(widget.isSignIn){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Password(isSignin: true)),
                    );
                  }else{
                    await checkUser(email: emailController.text);

                    if(isUserExist?? true){

                      Get.snackbar("Try Again!","Email is already registered");
                    }else{

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Password(isSignin: false)),

                      );

                    }
                  }
                }
            ),

          ],
        ),
      ),

    );
  }
}
