import 'package:flutter/material.dart';
import 'package:matrimony_flutter/Authentication/user_controllers.dart';
import 'package:matrimony_flutter/Home/loader.dart';
import 'package:matrimony_flutter/Userform/EditForm/user_form.dart';
import 'package:matrimony_flutter/Authentication/standard.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';
import 'search_bar.dart';
import 'app_bar.dart';
import 'get_list_item.dart';


class UserList extends StatefulWidget {
  bool search;
  UserList({super.key,required this.search});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {

//utils
  List<Map<String, dynamic>> searchList = [];
  List<Map<String, dynamic>> userList = [];
  List<String> cities = [];
  String? selectedCity;
  String? selectedGender;
  List<String> favList = [];

//methods
  void changeStateOfSearchBar(){
    setState(() {
      isSearchBar = false;
    });
  }

  void onChangeSearchData(searchData){
    setState(() {
      searchList = userList.where((user) {
        return user[FULLNAME].toString().toLowerCase().contains(searchData) ||
            user[CITY].toString().toLowerCase().contains(searchData) ||
            user[EMAIL].toString().toLowerCase().contains(searchData) ||
            user[MOBILE].toString().toLowerCase().contains(searchData) ||
            user[AGE].toString().toLowerCase().contains(searchData);
      }).toList();
    });
  }

  void favoriteUser(index,updatedUser){
      setState(() {
        updatedUser[ISFAVORITE] = !updatedUser[ISFAVORITE] ;

      });
  }

  Future<List<Map<String, dynamic>>> _getUserData() async {
  UserOperations userOperations = UserOperations();
  final currentUserEmail = Auth().currentUser?.email;

  if (currentUserEmail == null) return [];

  if (userList.isEmpty || selectedCity != null || selectedGender != null) {
    final allUsers = await userOperations.getAllUsers();
    List<Map<String, dynamic>> filteredUsers = [];

    for (var user in allUsers) {
      // Set favList for current user
      if (user[EMAIL] == currentUserEmail) {
        favList = List<String>.from(user[FAVORITELIST] ?? []);
        print("$favList **************");
        continue; // Skip adding current user to visible list
      }

      // Filter others based on profile and selected filters
      if (user[ISPROFILEDETAILS] == true) {
        bool matchesCity = selectedCity == null || user[CITY] == selectedCity;
        bool matchesGender = selectedGender == null || user[GENDER] == selectedGender;

        if (matchesCity && matchesGender) {
          filteredUsers.add(user);
        }
      }
    }

    userList = filteredUsers.reversed.toList(); // Show newest users first
  }

  return userList;
}


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: isSearchBarHide(widget,context,changeStateOfSearchBar,onChangeSearchData),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _getUserData(),
              builder: (context, snapshot) {
                 if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return GetListItem(index: index,userList: userList,searchList: searchList,favList: favList);
                    },
                    itemCount: searchController.text.isEmpty
                        ? userList.length
                        : searchList.length,
                  );
                } else {
                  return  LoadingWidget();
                 }
              },
            ),
          )
        ],
      ),
      floatingActionButton: Container(
          decoration: BoxDecoration(

            color: Colors.purple.shade400,
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: IconButton(onPressed: (){}, icon: Icon(Icons.filter_alt_sharp),color: Colors.white,)),
    );
  }
}