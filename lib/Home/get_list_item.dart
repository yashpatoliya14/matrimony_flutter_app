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


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder:
                  (context, animation, secondaryAnimation) =>
                      UserDetail(data: userList[index]),
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

        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 2000),
            curve: Curves.linear,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.white60],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white38,
                    child: const Icon(Icons.person, size: 35),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.59,
                              child: Text(
                                currentList[index][FULLNAME],
                                style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  color: Colors.purple.shade300,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.purple,
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        Row(
                          children: [
                            const Icon(Icons.location_city_outlined, size: 20),
                            const SizedBox(width: 5),
                            Text(
                              currentList[index][CITY],
                              style: const TextStyle(color: Colors.black54),
                            ),
                            const SizedBox(width: 5),

                            const Icon(Icons.email_outlined, size: 20),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: 100, // Adjust this width as needed
                              child: Text(
                                currentList[index][EMAIL],
                                style: const TextStyle(color: Colors.black54),
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 25,
                              child: TextButton.icon(
                                
                                onPressed: () async {
                                  if (searchController.text.isEmpty) {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    UserOperations userOperations =
                                        UserOperations();

                                    // Get logged-in user data
                                    Map<String, dynamic>? person =
                                        await userOperations.getUserByEmail(
                                          email:
                                              preferences
                                                  .getString("email")
                                                  .toString(),
                                        );

                                    if (person != null) {
                                      List<String> favoriteList = List<String>.from(
                                        person[FAVORITELIST] ?? [],
                                      );
                                      String selectedEmail =
                                          userList[index][EMAIL];

                                      // Toggle logic
                                      if (favList.contains(
                                        userList[index][EMAIL],
                                      )) {
                                        favoriteList.remove(selectedEmail);
                                        favList.remove(selectedEmail);
                                        setState(() {
                                          
                                        });
                                      } else {
                                        favoriteList.add(selectedEmail);
                                        favList.add(selectedEmail);
                                        setState(() {
                                          
                                        });
                                      }

                                      UserModel updatedUser = UserModel(
                                        FAVORITELIST: favoriteList,
                                      );

                                      await userOperations.updateUserByEmail(
                                        updatedData: updatedUser.toJson(),
                                        email:
                                            preferences
                                                .getString("email")
                                                .toString(),
                                      );
                                    }
                                  } else {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    UserOperations userOperations =
                                        UserOperations();

                                    // Get logged-in user data
                                    Map<String, dynamic>? person =
                                        await userOperations.getUserByEmail(
                                          email:
                                              preferences
                                                  .getString("email")
                                                  .toString(),
                                        );

                                    if (person != null) {
                                      List<String> favoriteList = List<String>.from(
                                        person[FAVORITELIST] ?? [],
                                      );
                                      String selectedEmail =
                                          searchList[index][EMAIL];

                                      // Toggle logic
                                      if (favList.contains(
                                        searchList[index][EMAIL],
                                      )) {
                                        favoriteList.remove(selectedEmail);
                                        favList.remove(selectedEmail);
                                        setState(() {
                                          
                                        });
                                      } else {
                                        favoriteList.add(selectedEmail);
                                        favList.add(selectedEmail);
                                        setState(() {
                                          
                                        });
                                      }

                                      UserModel updatedUser = UserModel(
                                        ISFAVORITE:
                                            searchList[index][ISFAVORITE],
                                        FAVORITELIST: favoriteList,
                                      );

                                      await userOperations.updateUserByEmail(
                                        updatedData: updatedUser.toJson(),
                                        email:
                                            preferences
                                                .getString(EMAIL)
                                                .toString(),
                                      );
                                    }
                                  }
                                },

                                icon: Icon(
                                  (searchController.text.isEmpty
                                          ? favList.contains(
                                            userList[index][EMAIL],
                                          )
                                          : favList.contains(
                                            searchList[index][EMAIL],
                                          ))
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  size: 20,
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
                                label:(searchController.text.isEmpty
                                              ? favList.contains(
                                                userList[index][EMAIL],
                                              )
                                              : favList.contains(
                                                searchList[index][EMAIL],
                                              ))
                                          ? Text("Liked")
                                          : Text("Like"),
                                
                                style: ButtonStyle(
                                  padding: WidgetStateProperty.all<EdgeInsets>(
                                    EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) => ChatScreen(
                                          receiverId: userList[index][ID],
                                        ),
                                    transitionsBuilder: (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                      child,
                                    ) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              label: Text("Message"),
                              icon: Icon(Iconsax.message),
                            ),
                          ],
                        ),
                        
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
