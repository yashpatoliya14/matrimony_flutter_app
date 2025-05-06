import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_flutter/Dependecies_import/auth_dependencies.dart';
import 'package:matrimony_flutter/Userform/Submit_Pages/city.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Gender extends StatefulWidget {
  const Gender({super.key});

  @override
  State<Gender> createState() => _NameProfilephotoState();
}

class _NameProfilephotoState extends State<Gender> {

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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenWidth*0.2),
              Container(
                child: Text(
                  "I am a",
                  style: GoogleFonts.nunito(
                    fontSize: 35,
                    fontWeight: FontWeight.w600
                  ),
                  ),
              ),
              SizedBox(height: screenWidth*0.1),
              Container(
                width: screenWidth * 0.9,
                margin: EdgeInsets.all(
                  MediaQuery.of(context).size.width * 0.025,
                ),
                child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                selectedRadio = 0;
                                genderError = null;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                              decoration: BoxDecoration(
                                color: selectedRadio == 0 ? Colors.purple.shade400 : Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.purple),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.male,
                                    color: selectedRadio == 0 ? Colors.white : Colors.purple,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Male",
                                    style: TextStyle(
                                      color: selectedRadio == 0 ? Colors.white : Colors.purple,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                selectedRadio = 1;
                                genderError = null;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                              decoration: BoxDecoration(
                                color: selectedRadio == 1 ? Colors.purple.shade400 : Colors.white,
                                borderRadius: BorderRadius.circular(50.0),
                                border: Border.all(color: Colors.purple),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.female,
                                    color: selectedRadio == 1 ? Colors.white : Colors.purple,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Female",
                                    style: TextStyle(
                                      color: selectedRadio == 1 ? Colors.white : Colors.purple,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              SizedBox(height: screenWidth*.02),
              
            ],
          ),
        ),
      ),

      floatingActionButton:
          buildFloatingActionButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                      prefs.setString("gender", selectedRadio==1 ? "Female":"Male");

                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context)=>City()));
                },
                context: context,
              ),
    );
  }
}
