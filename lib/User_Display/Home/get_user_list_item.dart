import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_flutter/User_Display/user_detail.dart';
import 'package:matrimony_flutter/Userform/user_form.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';

import './search_bar.dart';

Widget getListItem(int index,userList,searchList,context,widget,favoriteUser,updateUser,deleteUser) {
  final currentList = searchController.text.isEmpty ? userList : searchList;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    child: GestureDetector(
      onTap: () {

        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => UserDetail(data: userList[index]),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );

      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.59,
                            child: Text(

                              currentList[index][FULLNAME],
                              style: GoogleFonts.nunito(
                                  fontSize: 20, color:Colors.purple.shade300),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, color: Colors.purple),
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
                            width: 25,
                            height: 25,
                            child: IconButton(
                              onPressed: () async {
                                if(searchController.text.isEmpty){


                                  favoriteUser(index,userList[index]);
                                  await widget.user.updateUser(
                                    map: userList[index],
                                    id: int.parse(userList[index][ID]),
                                  );
                                }else{


                                  favoriteUser(index,searchList[index]);
                                  await widget.user.updateUser(
                                    map: searchList[index],
                                    id: int.parse(searchList[index][ID]),
                                  );
                                }


                              },


                              icon: Icon((searchController.text.isEmpty ? userList[index][ISFAVORITE] : searchList[index][ISFAVORITE])? Icons.favorite : Icons.favorite_outline,
                                  size: 20, color: (searchController.text.isEmpty ? userList[index][ISFAVORITE] : searchList[index][ISFAVORITE])? Colors.red : Colors.deepOrange),
                              style: ButtonStyle(
                                padding: WidgetStateProperty.all<EdgeInsets>(
                                    EdgeInsets.zero),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 65,
                            height: 25,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                  updateUser(index);
                              },
                              icon: const Icon(Icons.edit,
                                  size: 15, color: Colors.white),
                              label: Text(
                                "Edit",
                                style: GoogleFonts.nunito(
                                    fontSize: 12, color: Colors.white),
                              ),
                              style: ButtonStyle(
                                padding: WidgetStateProperty.all<EdgeInsets>(
                                    EdgeInsets.zero),
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    Colors.purple.shade300),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: 70,
                            height: 25,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: Text('DELETE', style: GoogleFonts.nunito(color: Colors.red.shade500)),
                                      content: Text('Are you sure want to delete?', style: GoogleFonts.nunito()),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {

                                            deleteUser(index);
                                          },
                                          child: Text('Yes', style: GoogleFonts.nunito()),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('No', style: GoogleFonts.nunito()),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.delete, size: 15, color: Colors.black45),
                              label: Text(
                                "Delete",
                                style: GoogleFonts.nunito(fontSize: 12, color: Colors.black45),
                              ),
                              style: ButtonStyle(
                                padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                                backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                              ),
                            ),
                          )

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
}