import 'package:matrimony_flutter/Utils/importFiles.dart';
import 'package:intl/intl.dart';
class UserForm extends StatefulWidget {
  bool isAppBar;
  Map<String, dynamic>? userDetail;
  UserForm({super.key, Map<String, dynamic>? userDetail,required this.isAppBar}) {
    this.userDetail = userDetail;
  }
  @override
  State<UserForm> createState() => _UserformState();
}

class _UserformState extends State<UserForm> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  //get userHobbies when user editable mode
  // Future<List<String>> getUserHobbies(widget,user) async {
  //   if (widget.userDetail != null) {
  //     return await user.getUserHobbies(userId: int.parse(widget.userDetail![ID]));
  //   }
  //   return [];
  // }

  void checkedHobbies(map,value){
    setState(() {
      map["isChecked"] = value!;
      hobbiesError = validateHobbies(); // Validate hobbies on checkbox change
    });
  }

  @override
  void initState() {
    super.initState();

    //if user editable mode then assign values to the controller text
    if (widget.userDetail != null) {

      fullnameController.text = widget.userDetail?[FULLNAME] ?? '';
      emailController.text = widget.userDetail?[EMAIL] ?? '';
      mobileController.text = widget.userDetail?[MOBILE].toString() ?? '';
      passwordController.text = widget.userDetail?[PASSWORD] ?? '';
      confirmPasswordController.text = widget.userDetail?[PASSWORD] ?? '';
      dobController.text = widget.userDetail?[DOB] ?? '';
      selectedRadio = widget.userDetail?[GENDER] == "Male" ? 0 : 1;
      selectedCity = widget.userDetail?[CITY] ?? cities[0];
      List<String> db = widget.userDetail?[DOB].split("/");
      selectedDate = DateTime(
          int.parse(db[2]),
          int.parse(db[1]),
          int.parse(db[0])
      );
      selectedHobbies = List<String>.from(widget.userDetail![HOBBY] ?? []);;
        for (var hobby in hobbiesData) {
          hobby["isChecked"] = selectedHobbies!.contains(hobby["name"]);
        }
      // getUserHobbies(widget,user).then((fetchedHobbies) {
      //   print("Fetched hobbies: $fetchedHobbies");
      //   setState(() {
      //     selectedHobbies = fetchedHobbies;
      //     for (var hobby in hobbiesData) {
      //       hobby["isChecked"] = selectedHobbies!.contains(hobby["name"]);
      //       print("Hobby ${hobby["name"]} isChecked: ${hobby["isChecked"]}");
      //     }
      //   });
      // });


      isFavorite = widget.userDetail![ISFAVORITE];

    } else {
      selectedCity = cities[0];
      selectedRadio = 0;
    }

  }



  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(

      appBar: widget.isAppBar ? PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
          child: getAppBar(context,name: "Register")
      ): null,


      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formkey,

            child: SizedBox(
              width: screenWidth,
              height: screenHeight,

              child: ListView(

                children: [

                  //fullname
                  Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.all(screenWidth * 0.025),

                    child: getTextFormField(
                      keyboardType: TextInputType.name,
                      controller: fullnameController,
                      label: 'Full name',
                      errorMsg: firstNameError,
                      icon: Iconsax.message,
                      validateFun: validateFirstName,
                    ),
                  ),

                  //Email
                  Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.all(screenWidth * 0.025),

                    child: getTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      label: 'Email',
                      errorMsg: emailError,
                      icon: Iconsax.message,
                      validateFun: validateEmail,
                    ),
                  ),

                  //mobile
                  Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.all(screenWidth * 0.025),
                    child: getTextFormField(
                      controller: mobileController,
                      label: 'Mobile',
                      errorMsg: mobileError,
                      validateFun: validateMobile,
                      keyboardType: TextInputType.phone,
                      inputFormator: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      icon: Iconsax.call
                    ),
                  ),

                  //password
                  Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.all(screenWidth * 0.025),
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
                      }, icon: ishidePass!?Icon( Icons.remove_red_eye):Icon( Icons.visibility_off)
                  ),
                      validateFun: validatePassword,
                    ),
                  ),

                  //confirm password
                  Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.all(screenWidth * 0.025),
                    child: getTextFormField(
                      controller: confirmPasswordController,
                      icon: Iconsax.password_check,
                      suffixIcon:IconButton(onPressed: (){
                        setState(() {
                          ishideConfirm=!ishideConfirm!;
                        });
                      }, icon: ishideConfirm!? Icon( Icons.remove_red_eye): Icon( Icons.visibility_off)),
                      hideText: ishideConfirm!,
                      label: "Confirm Password",
                      errorMsg: confirmPasswordError,
                      validateFun: validateConfirmPassword,
                    ),
                  ),

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
                      onChanged: (value){
                        if(_formkey.currentState!.validate() ??  true){
                          setState(() {
                            isDisplayFloatButton=true;
                          });
                        }
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
                          if(_formkey.currentState!.validate() ??  true){
                            setState(() {
                              isDisplayFloatButton=true;
                            });
                          }
                        }
                      },
                    ),
                  ),

                  //select gender
                  Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.all(screenWidth * 0.025),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Gender",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedRadio = 0;
                                  genderError = null;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: selectedRadio == 0 ? Colors.purple.shade400 : Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
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
                              onTap: () {
                                setState(() {
                                  selectedRadio = 1;
                                  genderError = null;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: selectedRadio == 1 ? Colors.purple.shade400 : Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
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
                        // getRadioButtonError(context)
                      ],
                    ),
                  ),

                  //select city
                  Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.all(screenWidth * 0.025),
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0), // Softer corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(2, 2), // Subtle shadow
                        ),
                      ],
                    ),
                    child: DropdownButtonFormField<String>(
                      value: selectedCity,
                      decoration: InputDecoration(
                        border: InputBorder.none, // Removes the default border
                        contentPadding: EdgeInsets.zero,
                      ),
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.purple), // Stylish dropdown icon
                      dropdownColor: Colors.white,
                      items: cities.map((city) {
                        return DropdownMenuItem(
                          value: city,
                          child: Text(
                            city,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedCity = value!;
                          cityError = validateCity(selectedCity);
                        });
                      },
                      validator: (value) => value == null ? "Please select a city" : null, // Validation
                    ),
                  ),

                  // getCityError(context),

                  //Hobbies
                  Container(
                  width: screenWidth*0.9,
                  margin: EdgeInsets.all(screenWidth*0.025),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hobbies:", style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),),
                      Wrap(
                        spacing: 10,
                        children: hobbiesData.map((hobby) {
                          return FilterChip(
                            label: Text(hobby["name"]),
                            selected: hobby["isChecked"],
                            backgroundColor: Colors.white,
                            selectedColor: Colors.purple.shade100,
                            onSelected: (bool selected) {
                              setState(() {
                                hobby["isChecked"] = selected;
                              });
                            },
                          );
                        }).toList(),
                      ),
                      // getHobbiesError(context)
                    ],
                  ),
                ),

                  //save button
                  Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.all(screenWidth * 0.025),

                    child: ElevatedButton(
                      style: ButtonStyle(
                        animationDuration: const Duration(milliseconds: 200),

                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.purple;
                            }
                            return Colors.purple; // Default color
                          },
                        ),

                        overlayColor: MaterialStateProperty.all(
                          Colors.white.withOpacity(0.6),
                        ),

                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        ),

                        // Customize the button's shape.
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      onPressed: () async {

                        if (_formkey.currentState?.validate() ?? false) {
                          selectedHobbies = hobbiesData
                              .where((hobby) => hobby["isChecked"])
                              .map((hobby) => hobby["name"] as String)
                              .toList();


                          final data = {
                              FULLNAME: fullnameController.text,
                              EMAIL: emailController.text,
                              MOBILE: mobileController.text,
                              PASSWORD: passwordController.text,
                              DOB: dobController.text,
                              GENDER: gender[selectedRadio!],
                              CITY: selectedCity,
                              HOBBY: selectedHobbies,
                              ISFAVORITE: isFavorite
                            };

                            if (widget.userDetail != null) {

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Save successful')),
                              );
                               user.updateUser(map: data, id: widget.userDetail![ID]);

                              data[ID] = widget.userDetail![ID];
                              Navigator.pop(context,data);

                            }
                            else {
                               user.addUser(map: data);
                              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Home(index: 0,)));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Add successful')),
                              );
                            }
                            setState(() {
                              fullnameController.clear();
                              emailController.clear();
                              mobileController.clear();
                              passwordController.clear();
                              confirmPasswordController.clear();
                              dobController.clear();
                              selectedRadio = null;
                              selectedCity = cities[0];
                              for (var hobby in hobbiesData) {
                                hobby["isChecked"] = false;
                              }
                            });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please fill all required fields')),
                          );
                        }
                      },

                      child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 16 ),),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}