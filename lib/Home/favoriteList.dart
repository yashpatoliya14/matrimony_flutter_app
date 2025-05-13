import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_flutter/Authentication/user_controllers.dart';
import 'package:matrimony_flutter/Authentication/user_model.dart';
import 'package:matrimony_flutter/Home/loader.dart';
import 'package:matrimony_flutter/User_Detail/user_detail.dart';
import 'package:matrimony_flutter/Authentication/standard.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favoritelist extends StatefulWidget {
  const Favoritelist({super.key});

  @override
  State<Favoritelist> createState() => _UserListState();
}

class _UserListState extends State<Favoritelist> {
  Future<List<Map<String, dynamic>>>? _userDataFuture;
  List<String> favList =[];
  @override
  void initState() {
    super.initState();
    _userDataFuture = _getUserData();
  }

  Future<List<Map<String, dynamic>>> _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userOperations = UserOperations();

    final String? currentEmail = prefs.getString(EMAIL);
    if (currentEmail == null) return [];

    List<Map<String, dynamic>> userList = await userOperations.getAllUsers();
    final userData = await userOperations.getUserByEmail(email: currentEmail);
    final List<String> favoriteListEmail = List<String>.from(
      userData?[FAVORITELIST] ?? [],
    );

    List<Map<String, dynamic>> favoriteList = [];
    for (var user in userList) {
      if (favoriteListEmail.contains(user[EMAIL])) {
        favoriteList.add(user);
      }
    }
    favList = favoriteListEmail;
    return favoriteList;
  }

  Future<void> onLike(String selectedEmail) async {
    SharedPreferences preferences = Get.find<SharedPreferences>();
    UserOperations userOperations = UserOperations();

    Map<String, dynamic>? person = await userOperations.getUserByEmail(
      email: preferences.getString(EMAIL).toString(),
    );

    if (person != null) {
      List<String> favoriteListEmailByUser = List<String>.from(
        person[FAVORITELIST] ?? [],
      );

      if (favoriteListEmailByUser.contains(selectedEmail)) {
        favoriteListEmailByUser.remove(selectedEmail);
        favList.remove(selectedEmail);
      } else {
        favoriteListEmailByUser.add(selectedEmail);
        favList.add(selectedEmail);
      
      }

      UserModel updatedUser = UserModel(FAVORITELIST: favoriteListEmailByUser);

      await userOperations.updateUserByEmail(
        updatedData: updatedUser.toJson(),
        email: preferences.getString(EMAIL).toString(),
      );

      // Refresh the data
      setState(() {
        _userDataFuture = _getUserData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.all(8.0)),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                 _userDataFuture = _getUserData();
              });
              await _userDataFuture;
            },
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _userDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No Favorite User', style: GoogleFonts.aBeeZee()),
                  );
                } else {
                  final favoriteList = snapshot.data!;
                  return ListView.builder(
                    itemCount: favoriteList.length,
                    itemBuilder: (context, index) {
                      return getListItem(favoriteList[index], index);
                    },
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget getListItem(Map<String, dynamic> user, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: isTablet ? 45 : 35,
                  backgroundImage: NetworkImage(user[PROFILEPHOTO] ?? ""),
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user[FULLNAME],
                        style: TextStyle(
                          fontSize: isTablet ? 20 : 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 10,
                        runSpacing: 6,
                        children: [
                          Row(
                            children: [
                              const Icon(Iconsax.location, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(user[CITY], style: const TextStyle(color: Colors.black54)),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.email, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(user[EMAIL], style: const TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          TextButton.icon(
                            onPressed: () => onLike(user[EMAIL]),
                            icon: Icon(
                                  favList.contains(user[EMAIL]) ? Iconsax.heart5 : Iconsax.heart,
                                  color:favList.contains(user[EMAIL])? Colors.red : Colors.deepOrange,
                                ),
                            label: Text(favList.contains(user[EMAIL]) ? "Liked" : "Like"),
                              
                            
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(
                                UserDetail(data: user),
                                transition: Transition.fade,
                              );
                            },
                            child: const Text(
                              "View Profile",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.indigo,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}