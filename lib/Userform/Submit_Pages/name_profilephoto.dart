import 'package:intl/intl.dart';
import 'package:matrimony_flutter/Userform/Submit_Pages/gender.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';

class NameProfilephoto extends StatefulWidget {
  const NameProfilephoto({super.key});

  @override
  State<NameProfilephoto> createState() => _NameProfilephotoState();
}

class _NameProfilephotoState extends State<NameProfilephoto> {
  GlobalKey<FormState> _name_profile = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: _name_profile,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenWidth * 0.2),
                Container(
                  child: Text(
                    "Profile details",
                    style: GoogleFonts.nunito(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: screenWidth * 0.1),
                Container(
                  width: screenWidth * 0.9,
                  margin: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.025,
                  ),
                  child: getTextFormField(
                    controller: fullnameController,
                    label: 'Full Name',
                    errorMsg: firstNameError,
                    icon: Iconsax.user,
                    validateFun: validateFirstName,

                  ),
                ),
                SizedBox(height: screenWidth * .02),
                Container(
                  width: screenWidth * 0.9,
                  margin: EdgeInsets.all(screenWidth * 0.025),
                  child: getTextFormField(
                    controller: dobController,
                    readOnly: true,
                    label: "Date of birth",
                    errorMsg: dobError,
                    validateFun: validateDOB,
                    icon: Iconsax.calendar,
                    labelColor: Colors.purple.shade400,
                    iconColor: Colors.purple.shade400,
                    contentColor: Colors.purple.shade400,
                    fillColor: Colors.purple.shade50,
                    onChanged: (value) {

                    },
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate!,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );

                      if (pickedDate != null && pickedDate != selectedDate) {
                        setState(() {
                          selectedDate = pickedDate;
                          dobController.text = DateFormat(
                            "dd/MM/yyyy",
                          ).format(selectedDate!); // Change format here
                          dobError = validateDOB(dobController.text);
                        });

                      }
                    },
                  ),
                ),
                buildButton(
                  label: "Save",
                  textColor: Colors.white,
                  backgroundColor: Colors.purple,
                  icon: Icon(Iconsax.next, color: Colors.white),
                  onPressed: () async {
                    if(_name_profile.currentState!.validate()){
                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                      prefs.setString("name", fullnameController.text);
                      prefs.setString("birthDate", dobController.text);

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Gender()),
                      );
                    }
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
