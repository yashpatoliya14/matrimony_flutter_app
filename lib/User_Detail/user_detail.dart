import 'package:matrimony_flutter/Home/app_bar.dart';
import '../../Utils/importFiles.dart'; // Ensure this file defines your constants

class UserDetail extends StatefulWidget {
  final Map<String, dynamic> data;
  const UserDetail({super.key, required this.data});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  User user = User();
  List<String> hobbies = [];

  // Future<List<String>> _getUserHobbies() async {
  //   return await user.getUserHobbies(userId: widget.data['UserId']);
  // }

  @override
  void initState() {
    super.initState();
    // _getUserHobbies().then((value) {
    //   setState(() {
    //     hobbies = value;
    //   });
    // });
  }
  final List<Color> appBarGradientColors = [Colors.red, Colors.purple.shade300];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
          child: getAppBar(context,name: "Matrimony")),
      // Background gradient
      body: Container(

        child: SafeArea(
          child: Column(
            children: [

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Picture
                      Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.purple.shade100,
                          backgroundImage: widget.data['profilePicture'] != null
                              ? NetworkImage(widget.data['profilePicture'])
                              : null,
                          child: widget.data['profilePicture'] == null
                              ? const Icon(Icons.person, size: 60, color: Colors.white)
                              : null,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // User Details Card
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.white.withOpacity(0.9), // Slight transparency
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              _buildUserInfo(Icons.person, "Name", widget.data[FULLNAME] ?? widget.data['name'] ?? 'N/A'),
                              _buildUserInfo(Icons.email, "Email", widget.data[EMAIL] ?? 'N/A'),
                              _buildUserInfo(Icons.phone, "Mobile", widget.data[MOBILE]?.toString() ?? 'N/A'),
                              _buildUserInfo(Icons.location_city, "City", widget.data[CITY] ?? 'N/A'),
                              _buildUserInfo(Icons.cake, "Date of Birth", widget.data[DOB] ?? 'N/A'),
                              _buildUserInfo(
                                widget.data[GENDER] == 'Male' ? Icons.male : Icons.female,
                                "Gender",
                                widget.data[GENDER] ?? 'N/A',
                              ),
                              _buildUserInfo(Icons.sports, "Hobbies",  widget.data[HOBBY]!=null ? widget.data[HOBBY].join(", ") : 'N/A'),
                            ],
                          ),
                        ),
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

  Widget _buildUserInfo(IconData icon, String title, String value) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, color: Colors.purple.shade600),
          title: Text(
            title,
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.w600,
              color: Colors.purple.shade600,
            ),
          ),
          subtitle: Text(
            value,
            style: GoogleFonts.nunito(fontSize: 16),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
