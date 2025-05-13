import 'package:flutter/material.dart';
import 'package:matrimony_flutter/Authentication/user_controllers.dart';
import 'package:matrimony_flutter/User_Detail/user_detail.dart';
import 'package:matrimony_flutter/Userform/EditForm/user_form.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';
import 'package:matrimony_flutter/launch_page.dart';

class getDrawer extends StatefulWidget {
  const getDrawer({super.key});

  @override
  State<getDrawer> createState() => _getDrawerState();
}

class _getDrawerState extends State<getDrawer> {

  void onEdit(){
    Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondAnimation) =>
                              UserForm(userDetail: userDetail!, isAppBar: true),
                      transitionsBuilder: (
                        context,
                        animation,
                        secondAnimation,
                        child,
                      ) {
                        return FadeTransition(child: child, opacity: animation);
                      },
                    ),
                  ).then((value) {
                    setState(() {
                      _getProfileDetails();
                    });
                  });
  }

  void onView(){
Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondAnimation) =>
                              UserDetail(data: userDetail!),
                      transitionsBuilder: (
                        context,
                        animation,
                        secondAnimation,
                        child,
                      ) {
                        return FadeTransition(child: child, opacity: animation);
                      },
                    ),
                  );
  }


  Map<String, dynamic>? userDetail;
  Future<Map<String, dynamic>?> _getProfileDetails() async {
    UserOperations userOperations = UserOperations();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return userOperations.getUserByEmail(
      email: prefs.getString(EMAIL).toString(),
    );
  }

  @override
  void initState() {
    super.initState();
    _getProfileDetails();
  }

  Future<void> signOut() async {
    await Auth().signOut();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LaunchPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300,
      child: FutureBuilder<Map<String, dynamic>?>(
        future: _getProfileDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading profile'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Profile not found'));
          }

          final profileData = snapshot.data!;
          userDetail = profileData;
          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  profileData[PROFILEPHOTO] ?? "https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg",
                ),
                backgroundColor: Colors.grey[200]),
              SizedBox(height: 10),
              Text(
                profileData['name'] ?? 'No Name',
                style: GoogleFonts.raleway(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                InkWell(child: Column(
                  children: [
                    Icon(Iconsax.edit),
                    Text("Edit",style: GoogleFonts.nunito(),)
                  ],
                ),
                onTap: (){
                  onEdit();
                },
                ),
                SizedBox(width: 15,),
                InkWell(child: Column(
                  children: [
                    Icon(Iconsax.eye),
                    Text("View",style: GoogleFonts.nunito(),)
                    
                  ],
                ),
                onTap: () {
                  onView();
                },
                )
                ]),
              SizedBox(height: 20),

              TextButton.icon(icon: Icon(Iconsax.logout),label: Text("Sign out",style: GoogleFonts.nunito(),),onPressed: (){
                signOut();    
              },),

              SizedBox(height: 20),
              ListTile(
                title: Row(
                  children: [
                    Text("Email", style: GoogleFonts.nunito()),
                    SizedBox(width: 2),
                    Icon(Iconsax.message, size: 15),
                  ],
                ),
                subtitle: Text(
                  profileData[EMAIL].toString(),
                  style: GoogleFonts.quicksand(fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 15),
              
              
            ],
          );
        },
      ),
    );
  }
}
