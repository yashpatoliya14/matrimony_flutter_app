import 'package:flutter/widgets.dart';
import 'package:matrimony_flutter/Dependecies_import/auth_dependencies.dart';

class NameProfilephoto extends StatefulWidget {
  const NameProfilephoto({super.key});

  @override
  State<NameProfilephoto> createState() => _NameProfilephotoState();
}

class _NameProfilephotoState extends State<NameProfilephoto> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 5),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
            child: getTextFormField(
              controller: fullnameController,
              label: 'Full Name',
              errorMsg: firstNameError,
              icon: Iconsax.user,
              validateFun: validateFirstName,
            ),
          ),
        ],
      ),
    );
  }
}
