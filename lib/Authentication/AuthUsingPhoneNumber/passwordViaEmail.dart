import 'package:matrimony_flutter/Dependecies_import/auth_dependencies.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';

class PasswordViaEmail extends StatefulWidget {
  const PasswordViaEmail({super.key});

  @override
  State<PasswordViaEmail> createState() => _PasswordViaEmailState();
}

class _PasswordViaEmailState extends State<PasswordViaEmail> {

  bool _isDisplayButton = false;
  GlobalKey<FormState> _formkeyOfPassword = GlobalKey();

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
                        suffixIcon:IconButton(onPressed: (){
                          setState(() {
                            ishidePass=!ishidePass!;
                          });
                        }, icon: ishidePass!?Icon( Iconsax.eye_slash):Icon( Iconsax.eye)
                    ),
                    onChanged: (){
                      if(_formkeyOfPassword.currentState?.validate() ?? true ){
                        _isDisplayButton = true;
                        setState(() {
                          
                        });
                      }else{
                        _isDisplayButton = false;
                        setState(() {
                          
                        });
                      }
                    },
                        validateFun: validatePassword,
                      ),
                    ),
          ],
        ),
      ),
      floatingActionButton:_isDisplayButton ?FloatingActionButton(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        onPressed: () {
          
        },
        child: Icon(Iconsax.arrow_circle_right),
      ):null,
    );
  }
}
