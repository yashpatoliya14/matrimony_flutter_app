import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:matrimony_flutter/Authentication/user_controllers.dart';
import 'package:matrimony_flutter/Authentication/user_model.dart';
import 'package:matrimony_flutter/Chat/chat_screen.dart';
import 'package:matrimony_flutter/Home/favoriteList.dart';
import 'package:matrimony_flutter/User_Detail/user_detail.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';

import 'search_bar.dart';

class GetListItem extends StatefulWidget {
  final int index;
  final List<Map<String, dynamic>> userList;
  final List<Map<String, dynamic>> searchList;
  final List<String> favList;

  const GetListItem({
    Key? key,
    required this.index,
    required this.userList,
    required this.searchList,
    required this.favList,
  }) : super(key: key);

  //methods

  @override
  State<GetListItem> createState() => _GetListItemState();
}

class _GetListItemState extends State<GetListItem> {
  @override
  Widget build(BuildContext context) {
    final int index = widget.index;
    final List<Map<String, dynamic>> userList = widget.userList;
    final List<Map<String, dynamic>> searchList = widget.searchList;
    final List<String> favList = widget.favList;
    final currentList = searchController.text.isEmpty ? userList : searchList;

    void onLike() async {
      if (searchController.text.isEmpty) {
        SharedPreferences preferences = Get.find<SharedPreferences>();
        UserOperations userOperations = UserOperations();

        // Get logged-in user data
        Map<String, dynamic>? person = await userOperations.getUserByEmail(
          email: preferences.getString("email").toString(),
        );

        if (person != null) {
          List<String> favoriteList = List<String>.from(
            person[FAVORITELIST] ?? [],
          );
          String selectedEmail = userList[index][EMAIL];

          // Toggle logic
          if (favList.contains(userList[index][EMAIL])) {
            favoriteList.remove(selectedEmail);
            favList.remove(selectedEmail);
            setState(() {});
          } else {
            favoriteList.add(selectedEmail);
            favList.add(selectedEmail);
            setState(() {});
          }

          UserModel updatedUser = UserModel(FAVORITELIST: favoriteList);

          await userOperations.updateUserByEmail(
            updatedData: updatedUser.toJson(),
            email: preferences.getString("email").toString(),
          );
        }
      } else {
        SharedPreferences preferences = Get.find<SharedPreferences>();
        UserOperations userOperations = UserOperations();

        // Get logged-in user data
        Map<String, dynamic>? person = await userOperations.getUserByEmail(
          email: preferences.getString("email").toString(),
        );

        if (person != null) {
          List<String> favoriteList = List<String>.from(
            person[FAVORITELIST] ?? [],
          );
          String selectedEmail = searchList[index][EMAIL];

          // Toggle logic
          if (favList.contains(searchList[index][EMAIL])) {
            favoriteList.remove(selectedEmail);
            favList.remove(selectedEmail);
            setState(() {});
          } else {
            favoriteList.add(selectedEmail);
            favList.add(selectedEmail);
            setState(() {});
          }

          UserModel updatedUser = UserModel(
            ISFAVORITE: searchList[index][ISFAVORITE],
            FAVORITELIST: favoriteList,
          );

          await userOperations.updateUserByEmail(
            updatedData: updatedUser.toJson(),
            email: preferences.getString(EMAIL).toString(),
          );
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            width: double.infinity,
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
                // Profile Image
                CircleAvatar(
                  radius: isTablet ? 45 : 35,
                  backgroundImage: NetworkImage(
                    currentList[index][PROFILEPHOTO] ?? "",
                  ),
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(width: 12),

                // Details Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Text(
                        userList[index][FULLNAME],
                        style: TextStyle(
                          fontSize: isTablet ? 20 : 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),

                      // Email & City
                      Wrap(
                        spacing: 10,
                        runSpacing: 6,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Iconsax.location,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                currentList[index][CITY],
                                style: const TextStyle(color: Colors.black54),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.email,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                currentList[index][EMAIL],
                                style: const TextStyle(color: Colors.black54),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Buttons
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          // Like Button
                          TextButton.icon(
                            onPressed: onLike,
                            icon: Icon(
                              (searchController.text.isEmpty
                                      ? favList.contains(userList[index][EMAIL])
                                      : favList.contains(
                                        searchList[index][EMAIL],
                                      ))
                                  ? Iconsax.heart5
                                  : Iconsax.heart,
                              color:
                                  (searchController.text.isEmpty
                                          ? favList.contains(
                                            userList[index][EMAIL],
                                          )
                                          : favList.contains(
                                            searchList[index][EMAIL],
                                          ))
                                      ? Colors.red
                                      : Colors.deepOrange,
                            ),
                            label: Text(
                              (searchController.text.isEmpty
                                      ? favList.contains(userList[index][EMAIL])
                                      : favList.contains(
                                        searchList[index][EMAIL],
                                      ))
                                  ? "Liked"
                                  : "Like",
                            ),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                            ),
                          ),

                          // Message Button
                          TextButton.icon(
                            onPressed: () {
                              Get.to(
                                ChatScreen(
                                  receiverId: userList[index][ID],
                                  receiverName: userList[index][FULLNAME],
                                ),
                                transition: Transition.fade,
                              );
                            },
                            icon: const Icon(Iconsax.message),
                            label: const Text("Message"),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.purple,
                            ),
                          ),

                          // View Profile
                          TextButton(
                            onPressed: () {
                              Get.to(
                                UserDetail(data: userList[index]),
                                transition: Transition.fadeIn,
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
