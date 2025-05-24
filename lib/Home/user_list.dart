import 'package:flutter/material.dart';
import 'package:matrimony_flutter/Authentication/user_controllers.dart';
import 'package:matrimony_flutter/Home/loader.dart';
import 'package:matrimony_flutter/Home/userlist_provider.dart';
import 'package:matrimony_flutter/Userform/EditForm/user_form.dart';
import 'package:matrimony_flutter/Authentication/standard.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';
import 'package:provider/provider.dart';
import 'search_bar.dart';
import 'app_bar.dart';
import 'get_list_item.dart';

class UserList extends StatefulWidget {
  bool search;
  UserList({super.key, required this.search});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  //utils
  List<Map<String, dynamic>> searchList = [];

  bool _loading = false;

  //methods
  void changeStateOfSearchBar() {
    setState(() {
      isSearchBar = false;
    });
  }

  void onChangeSearchData(searchData) {
    setState(() {
      List<Map<String,dynamic>> userList = Provider.of<UserListProvider>(context,listen: false).userList;
      searchList =
          userList.where((user) {
            return user[FULLNAME].toString().toLowerCase().contains(
                  searchData,
                ) ||
                user[CITY].toString().toLowerCase().contains(searchData) ||
                user[EMAIL].toString().toLowerCase().contains(searchData) ||
                user[MOBILE].toString().toLowerCase().contains(searchData) ||
                user[AGE].toString().toLowerCase().contains(searchData);
          }).toList();
    });
  }

  // Future<List<Map<String, dynamic>>> _getUserData() async {
  //   UserOperations userOperations = UserOperations();
  //   final currentUserEmail = Auth().currentUser?.email;

  //   if (currentUserEmail == null) return [];

  //   if (userList.isEmpty || selectedCity != null || selectedGender != null) {
  //     final allUsers = await userOperations.getAllUsers();
  //     List<Map<String, dynamic>> filteredUsers = [];

  //     for (var user in allUsers) {
  //       // Set favList for current user
  //       if (user[EMAIL] == currentUserEmail) {
  //         favList = List<String>.from(user[FAVORITELIST] ?? []);
  //         continue; // Skip adding current user to visible list
  //       }

  //       // Filter others based on profile and selected filters
  //       if (user[ISPROFILEDETAILS] == true) {
  //         bool matchesCity = selectedCity == null || user[CITY] == selectedCity;
  //         bool matchesGender =
  //             selectedGender == null || user[GENDER] == selectedGender;

  //         if (matchesCity && matchesGender) {
  //           filteredUsers.add(user);
  //         }
  //       }
  //     }

  //     userList = filteredUsers.reversed.toList(); // Show newest users first
  //   }

  //   return userList;
  // }

  Future<void> _fetchApi({bool? refresh}) async {
    _loading = true;
    final provider = Provider.of<UserListProvider>(context, listen: false);
    await provider.getUserData(refresh: refresh ?? false).then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchApi();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserListProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: isSearchBarHide(
              widget,
              context,
              changeStateOfSearchBar,
              onChangeSearchData,
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                  provider.userList = []; 
                _fetchApi(refresh:true);
              },
              child:
                  !_loading
                      ? ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return GetListItem(
                            index: index,
                            userList: provider.userList,
                            searchList: searchList,
                            favList: provider.favList,
                          );
                        },
                        itemCount:
                            searchController.text.isEmpty
                                ? provider.userList.length
                                : searchList.length,
                      )
                      : LoadingWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
