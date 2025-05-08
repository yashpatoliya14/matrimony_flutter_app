
import 'package:matrimony_flutter/Utils/importFiles.dart';

int activeIndex = 0;
bool isSearchBar = false;

Widget getAppBar(context, {onClickSearchBar,name,actionsList}){
  final List<Color> appBarGradientColors = [Colors.purple.shade400, Colors.purple];

  return AppBar(
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: appBarGradientColors,
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
      ),
    ),
    leading: Builder(
      builder: (context) => IconButton(
        icon: Icon(FontAwesomeIcons.stream,color: Colors.white70,), // <-- Change this to any icon you want
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(15),
      ),
    ),
    title: Text(
      name,
      style: GoogleFonts.nunito(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 25,
      ),
    ),
    actions: actionsList,
  );
}
