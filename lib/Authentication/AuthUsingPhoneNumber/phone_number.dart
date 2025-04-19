import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:matrimony_flutter/Dependecies_import/auth_dependencies.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  final TextEditingController _controllerPhoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 150),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListTile(
              title: Text(
                "My Mobile",
                style: GoogleFonts.nunito(fontSize: 40),
                textAlign: TextAlign.left,
              ),
              subtitle: Text(
                "Please enter your valid phone number. We will send you a 4-digit code to verify your account.",
                style: GoogleFonts.nunito(fontSize: 15),
                textAlign: TextAlign.left,
              ),
            ),
          ),

          SizedBox(height: 20),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child:getTextFormField(
              icon: Iconsax.mobile,
              
            )
          ),
        ],
      ),
    );
  }
}
