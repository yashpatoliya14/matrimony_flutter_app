import 'package:matrimony_flutter/Authentication/user_controllers.dart';
import 'package:matrimony_flutter/Authentication/user_model.dart';
import 'package:matrimony_flutter/Userform/Submit_Pages/mobile.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';

class Hobbies extends StatefulWidget {
  const Hobbies({super.key});

  @override
  State<Hobbies> createState() => _HobbiesState();
}

class _HobbiesState extends State<Hobbies> {
  GlobalKey<FormState> _Hobbies = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isDisplayFloatButton = false;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: _Hobbies,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenWidth * 0.2),
              Container(
                child: Text(
                  "Select your Hobbies",
                  style: GoogleFonts.nunito(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: screenWidth * 0.1),
              Container(
                width: screenWidth * 0.9,
                margin: EdgeInsets.all(screenWidth * 0.025),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      spacing: 10,
                      alignment: WrapAlignment.center,
                      children:
                          hobbiesData.map((hobby) {
                            return Container(
                              margin: EdgeInsets.all(5),
                              child: FilterChip(
                                labelPadding: EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 10,
                                ),
                                label: Text(hobby["name"]),
                                selected: hobby["isChecked"],
                                backgroundColor: Colors.white,
                                selectedColor: Colors.purple.shade100,
                                onSelected: (bool selected) {
                                  setState(() {
                                    hobby["isChecked"] = selected;
                                  });
                                },
                              ),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),
              buildButton(
                label: "Next",
                textColor: Colors.white,
                backgroundColor: Colors.purple,
                icon: Icon(Iconsax.next, color: Colors.white),
                onPressed: () async {
                  selectedHobbies =
                      hobbiesData
                          .where((hobby) => hobby["isChecked"])
                          .map((hobby) => hobby["name"] as String)
                          .toList();
                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();

                  UserModel userModel = UserModel(HOBBIES: selectedHobbies!);
                  UserOperations userOperations = UserOperations();
                  userOperations.updateUserByEmail(email: prefs.getString(EMAIL).toString(), updatedData: userModel.toJson());

                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (context,animation,secondaryAnimation) => Home(),
                        transitionsBuilder:(context,animation,secondaryAnimation,child){
                          return FadeTransition(
                              child:child,
                              opacity:animation
                          );
                        }
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
