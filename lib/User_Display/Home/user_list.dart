import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_flutter/User_Display/loader.dart';
import 'package:matrimony_flutter/User_Display/user_detail.dart';
import 'package:matrimony_flutter/Userform/form_utils.dart';
import 'package:matrimony_flutter/Userform/user_form.dart';
import 'package:matrimony_flutter/Utils/standard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/crud_operation.dart';
import './search_bar.dart';
import '../app_bar.dart';
import './get_user_list_item.dart';


class UserList extends StatefulWidget {
  final User user = User();
  bool search;
  UserList({super.key,required this.search});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<Map<String, dynamic>> searchList = [];
  List<Map<String, dynamic>> userList = [];
  List<Map<String,dynamic>> filteredUsers = [];
  List<double> _scaleFactors = [];
  List<String> cities = [];
  String? selectedCity;
  String? selectedGender;

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

  void updateUser(index){
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => UserForm(userDetail: searchController.text.isEmpty ? userList[index] : searchList[index],isAppBar: true,),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ).then((value){
      if (value != null) {
        // Find the user in userList and searchList by ID and update them
        final userId = value[ID];
        final userIndex = userList.indexWhere((user) => user[ID] == userId);
        if (userIndex != -1) {
          setState(() {
            userList[userIndex] = value;
          });
        }
        final searchIndex = searchList.indexWhere((user) => user[ID] == userId);
        if (searchIndex != -1) {
          setState(() {
            searchList[searchIndex] = value;
          });
        }
      }
    });
  }

  void deleteUser(index) async{
    final userToDelete = searchController.text.isEmpty
        ? userList[index]
        : searchList[index];
    final userId = userToDelete[ID];

    Navigator.pop(context);
    await widget.user.deleteUser(id: userId);

    userList.removeWhere((user) => user[ID] == userId);
    searchList.removeWhere((user) => user[ID] == userId);

    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  Future<List<Map<String, dynamic>>> _getUserData() async {
    if (userList.isEmpty || selectedCity != null || selectedGender != null ) {
      userList = await widget.user.getUserList();
      userList = userList.reversed.toList();
    }

    return userList; // Apply filters to cached data
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
                  _scaleFactors = List.filled(userList.length, 1.0);
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return getListItem(index,userList,searchList,context,widget,favoriteUser,updateUser,deleteUser);
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