import 'package:flutter/material.dart';
import 'package:matrimony_flutter/Authentication/user_controllers.dart';
import 'package:matrimony_flutter/Home/drawer_provider.dart';
import 'package:matrimony_flutter/User_Detail/user_detail.dart';
import 'package:matrimony_flutter/Userform/EditForm/user_form.dart';
import 'package:matrimony_flutter/Userform/Submit_Pages/Hobbies.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';
import 'package:matrimony_flutter/launch_page.dart';
import 'package:provider/provider.dart';

class getDrawer extends StatefulWidget {
  const getDrawer({super.key});

  @override
  State<getDrawer> createState() => _getDrawerState();
}

class _getDrawerState extends State<getDrawer> {
  void onEdit() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder:
            (context, animation, secondAnimation) =>
                UserForm(userDetail: Provider.of<DrawerProvider>(context,listen: false).userDetail!, isAppBar: true),
        transitionsBuilder: (context, animation, secondAnimation, child) {
          return FadeTransition(child: child, opacity: animation);
        },
      ),
    ).then((value) {
      setState(() {
        _fetchUserDetail(true);
      });
    });
  }

  bool _loading = false;
  Future<void> _fetchUserDetail([refresh=false]) async {
    _loading =true;
    final provider = Provider.of<DrawerProvider>(context,listen: false);
    await provider.getProfileDetails(refresh).then((value){
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUserDetail();
  }

  Future<void> signOut() async {
    await Auth().signOut();

    Get.offAll(LaunchPage(), transition: Transition.fade);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DrawerProvider>(context);
    return Drawer(
      width: 300,
      child:
          !_loading
              ? ListView(
                padding: EdgeInsets.all(16),
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image.network(
                        provider.userDetail![PROFILEPHOTO] ??
                            "https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg",
                        fit:
                            BoxFit
                                .cover, // Ensures it fills the circle correctly
                        errorBuilder:
                            (context, error, stackTrace) => Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey,
                            ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  Text(
                    provider.userDetail!['name'] ?? 'No Name',
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
                      InkWell(
                        child: Column(
                          children: [
                            Icon(Iconsax.edit),
                            Text("Edit", style: GoogleFonts.nunito()),
                          ],
                        ),
                        onTap: () {
                          onEdit();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  TextButton.icon(
                    icon: Icon(Iconsax.logout),
                    label: Text("Sign out", style: GoogleFonts.nunito()),
                    onPressed: () {
                      signOut();
                    },
                  ),

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
                      provider.userDetail![EMAIL].toString(),
                      style: GoogleFonts.quicksand(fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 15),
                  ListTile(
                    title: Row(
                      children: [
                        Text("Gender", style: GoogleFonts.nunito()),
                        SizedBox(width: 2),
                        Icon(
                          provider.userDetail![GENDER].toString() == "Male"
                              ? Iconsax.man
                              : Iconsax.woman,
                          size: 15,
                        ),
                      ],
                    ),
                    subtitle: Text(
                      provider.userDetail![GENDER].toString(),
                      style: GoogleFonts.quicksand(fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 15),
                  ListTile(
                    title: Row(
                      children: [
                        Text("City", style: GoogleFonts.nunito()),
                        SizedBox(width: 2),
                        Icon(Iconsax.building, size: 15),
                      ],
                    ),
                    subtitle: Text(
                      provider.userDetail![CITY].toString(),
                      style: GoogleFonts.quicksand(fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 15),
                  ListTile(
                    title: Row(
                      children: [
                        Text("Hobbies", style: GoogleFonts.nunito()),
                        SizedBox(width: 2),
                        Icon(Iconsax.note_favorite, size: 15),
                      ],
                    ),
                    subtitle: Text(
                      provider.userDetail![HOBBIES].join(", "),
                      style: GoogleFonts.quicksand(fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 15),
                  ListTile(
                    title: Row(
                      children: [
                        Text("Date of birth", style: GoogleFonts.nunito()),
                        SizedBox(width: 2),
                        Icon(Iconsax.calendar, size: 15),
                      ],
                    ),
                    subtitle: Text(
                      provider.userDetail![DOB],
                      style: GoogleFonts.quicksand(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              )
              : Center(child: CircularProgressIndicator()),
    );
  }
}
