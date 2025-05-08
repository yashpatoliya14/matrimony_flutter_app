import 'package:firebase_auth/firebase_auth.dart';
import 'package:matrimony_flutter/Authentication/widget_tree.dart';
import 'package:matrimony_flutter/Utils/importFiles.dart';

class VerifyEmailAddress extends StatefulWidget {
  const VerifyEmailAddress({super.key});

  @override
  State<VerifyEmailAddress> createState() => _VerifyEmailAddressState();
}

class _VerifyEmailAddressState extends State<VerifyEmailAddress> {

  void registerUser({
    required FullName,
    required Email,
    required Mobile,
    required Dob,
    required Gender,
    required City,
    required Hobbies,
    required Password,

  }){
    print(Mobile);
    final data = {
      FULLNAME: FullName,
      EMAIL: Email,
      MOBILE: Mobile,
      PASSWORD: Password,
      DOB: Dob,
      GENDER: Gender,
      CITY: City,
      HOBBY: Hobbies,
      ISFAVORITE: false,

    };
    user.addUser(map: data);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    sendForVerifyEmail();
  }

  Future<void> sendForVerifyEmail() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification().then((
      value,
    ) {
      SnackBar(content: Text("Successful"));
    });
  }

  void reload() {
    FirebaseAuth.instance.currentUser!.reload().then((value) async {
      SharedPreferences prefs =
          await SharedPreferences.getInstance();
      registerUser(
        FullName: prefs.getString("name"),
        Dob:prefs.getString("birthDate"),
        Email:prefs.getString("emailSignup"),
        Mobile:prefs.getInt("mobileSignup"),
        Gender: prefs.getString("gender"),
        Hobbies: prefs.getStringList("hobbies"),
        City: prefs.getString("city"),
        Password: prefs.getString("passwordSignup"),

      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WidgetTree()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 150),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListTile(
              title: Text(
                "Verify Email Address",
                style: GoogleFonts.nunito(fontSize: 40),
                textAlign: TextAlign.left,
              ),
              subtitle: Text(
                "Verification link sent to email box",
                style: GoogleFonts.nunito(fontSize: 20),
                textAlign: TextAlign.left,
              ),
            ),
          ),

          SizedBox(height: 20),

        ],
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          reload();
        },
        icon: Icon(Iconsax.refresh),
      ),
    );
  }
}
