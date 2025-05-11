import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_flutter/Authentication/user_controllers.dart';
import 'package:matrimony_flutter/Authentication/user_model.dart';
import 'package:matrimony_flutter/Home/loader.dart';
import 'package:matrimony_flutter/User_Detail/user_detail.dart';
import 'package:matrimony_flutter/Utils/standard.dart';
import '../../Utils/crud_operation.dart';

class Favoritelist extends StatefulWidget {

  const Favoritelist({super.key});

  @override
  State<Favoritelist> createState() => _UserListState();
}

class _UserListState extends State<Favoritelist> {
  

  List<Map<String, dynamic>> userList=[];
  List<Map<String, dynamic>> favoriteList=[];

  @override
  void initState() {
    super.initState();
  }

  Future<List<Map<String, dynamic>>> _getUserData() async {
    UserOperations userOperations =UserOperations();
    if(userList.isEmpty){

        userList = await userOperations.getAllUsers();
        favoriteList.clear();
    }
    favoriteList.clear();
    for (var user in userList) {
      if (user[ISFAVORITE]) {
        favoriteList.add(user);
      }
    }


    return favoriteList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        //temp search
        Padding(
          padding: const EdgeInsets.all(8.0),
        ),

        //list of favorite users
        Expanded(

          child: FutureBuilder<List<Map<String, dynamic>>>(future: _getUserData(), builder: (context,snapshot){

            if(snapshot.hasData){
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return getListItem(index);
                },
                itemCount: favoriteList.length,
              );
            }else if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingWidget();
            } else {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
          }),

        )
      ],
    );
  }

  Widget getListItem(int index) {
    final currentList = favoriteList ;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),

      child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => UserDetail(data: favoriteList[index]),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
        child: Container(

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
                  child: const Icon(
                    Icons.person,
                    size: 35,
                  ),
                ),
              ),

              Expanded(

                child: Padding(
                  padding: const EdgeInsets.all(8.0),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      //fullname
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.59,
                            child: Text(
                              currentList[index][FULLNAME],
                              style: GoogleFonts.nunito(
                              fontSize: 20, color: Colors.purple.shade400),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, color: Colors.purple),
                        ],
                      ),

                      const SizedBox(height: 5),

                      //city
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
                      const SizedBox(height: 5),

                      //buttons favorite
                      Row(
                        children: [
                          SizedBox(
                            width: 25,
                            height: 25,
                            child: IconButton(
                              onPressed: () async {
                                setState(() {
                                  favoriteList[index][ISFAVORITE] = !favoriteList[index][ISFAVORITE] ;

                                });
                                UserModel userModel = UserModel(ISFAVORITE: !favoriteList[index][ISFAVORITE]);
                                  UserOperations userOperations =UserOperations();

                                  await userOperations.updateUserByEmail(
                                    updatedData: userModel.toJson(),
                                    email: favoriteList[index][EMAIL],
                                  );

                              },

                              icon: Icon(
                                favoriteList[index][ISFAVORITE]
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                size: 20,
                                color: Colors.red,
                              ),
                              style: ButtonStyle(
                                padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                              ),
                            ),
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
    );
  }

  // Widget isSearchBarHide() {
  //   if () {
  //     return Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Container(
  //           width: MediaQuery.of(context).size.width * 0.95,
  //           child: TextFormField(
  //             controller: search,
  //             decoration: InputDecoration(
  //               hintText: "search",
  //               suffixIcon: IconButton(
  //                 onPressed: () {
  //                   setState(() {
  //                     // searchBarState = false;
  //                   });
  //                 },
  //                 icon: const Icon(Icons.close),
  //               ),
  //             ),
  //             onChanged: (value) {
  //               setState(() {
  //                 // searchList = searchDetail(searchData: value) ?? [];
  //               });
  //             },
  //           ),
  //         ),
  //       ],
  //     );
  //   } else {
  //     return const SizedBox.shrink();
  //   }
  // }
}

