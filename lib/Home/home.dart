import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:matrimony_flutter/Home/about_page.dart';
import 'package:matrimony_flutter/Home/favoriteList.dart';
import 'package:matrimony_flutter/Userform/EditForm/user_form.dart';
import 'package:matrimony_flutter/Home/user_list.dart';
import 'package:animations/animations.dart';
import 'package:matrimony_flutter/launch_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Authentication/auth.dart';

class Home extends StatefulWidget {
  final int index;

  // Constructor with a default value for index if null
  const Home({super.key, this.index = 0});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LaunchPage()),
    );
  }

   List<dynamic>? details;

  @override
  void initState() {
    super.initState();
    // Initialize activeIndex with widget.index if passed, else default to 0

    activeIndex = widget.index;
  }

  Future<void> _getProfileDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    details!.add(prefs.getString("name")?? "");
    details!.add(prefs.getString("email")?? "");
    details!.add(prefs.getString("gender")?? "");
    details!.add(prefs.getString("city")?? "");
    details!.add(prefs.getStringList("hobbies")?? "");

  }


  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      UserList(search: isSearchBar),
      UserForm(isAppBar: false),
      Favoritelist(),
    ];
    void onClickSearchBar() {
      setState(() {
        isSearchBar = true;
        activeIndex = 0;
      });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.08,
        ),

        child: getAppBar(
          context,
          onClickSearchBar: onClickSearchBar,
          name: "Matrimony",
          actionsList: [
            IconButton(
              onPressed: () {
                onClickSearchBar();
              },
              icon: const Icon(Iconsax.search_normal, color: Colors.white),
              iconSize: 25,
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder:
                        (context, animation, secondaryAnimation) => AboutPage(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
              },
              icon: const Icon(Iconsax.info_circle, color: Colors.white),
              iconSize: 25,
            ),
          ],
        ),
      ),

      drawer: SafeArea(
        child: Drawer(
          width: 300,
          child: ListView(
            children: [
              DrawerHeader(child: Text(details?[0]!=null ? "${details?[0]}" : "")),
              ListTile(title: Text(details?[1]!=null ? "${details?[1]}" : "")),
              ListTile(title: Text(details?[2]!=null ? "${details?[2]}" : "")),
              ListTile(title: Text(details?[3]!=null ? "${details?[3]}" : "")),
              ListTile(title: Text(details?[4]!=null ? "${details?[4]}" : "")),
              ListTile(title: Text((user?.email).toString())),
              ElevatedButton(
                onPressed: () {
                  signOut();
                },
                child: Text("SignOut"),
              ),
            ],
          ),
        ),
      ),

      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: pages[activeIndex],
      ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            activeIndex = index;
          });
        },
        currentIndex: activeIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.purple.shade50,
        selectedItemColor: Colors.purple, // Keep colors unchanged
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Iconsax.user_add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Iconsax.heart), label: 'Favorite'),
        ],
      ),
    );
  }
}
