import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:matrimony_flutter/User_Display/app_bar.dart';
import 'package:matrimony_flutter/Authentication/widget_tree.dart';

class VerifyEmailAddress extends StatefulWidget {
  const VerifyEmailAddress({super.key});

  @override
  State<VerifyEmailAddress> createState() => _VerifyEmailAddressState();
}

class _VerifyEmailAddressState extends State<VerifyEmailAddress> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    sendForVerifyEmail();
  }
  
  Future<void> sendForVerifyEmail() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value){
        SnackBar(content: Text("Successful"));
    });
  }

  void reload(){
    FirebaseAuth.instance.currentUser!.reload().then((value){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WidgetTree()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.08,
        ),
        child: getAppBar(context, name: "Verify Email Address"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("sent successful")
          ],  
        ),
      ),
      floatingActionButton: IconButton(onPressed: (){
        reload();
      },icon: Icon(Iconsax.refresh),),
    );
  }
}
