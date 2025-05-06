import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_flutter/Dependecies_import/auth_dependencies.dart';
import 'package:matrimony_flutter/Userform/Submit_Pages/gender.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenWidth*0.2),
                 Container(
                  child: Text(
                    "Select your Hobbies",
                    style: GoogleFonts.nunito(
                      fontSize: 35,
                      fontWeight: FontWeight.w600
                    ),
                    ),
                ),
                SizedBox(height: screenWidth*0.1),
                Container(
                  width: screenWidth*0.9,
                  margin: EdgeInsets.all(screenWidth*0.025),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 10,
                        
                        children: hobbiesData.map((hobby) {
                          return Container(
                            margin: EdgeInsets.all(5),
                            child: FilterChip(
                              labelPadding: EdgeInsets.symmetric(horizontal: 25,vertical:10 ),
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
                      // getHobbiesError(context)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton:
      buildFloatingActionButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                      prefs.setStringList("name", selectedHobbies!);

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                },
                context: context,
              ),
    );
  }
}
