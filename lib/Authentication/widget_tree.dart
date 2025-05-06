import 'package:matrimony_flutter/Dependecies_import/auth_dependencies.dart';
import 'package:matrimony_flutter/Userform/Submit_Pages/name_profilephoto.dart';
import 'package:matrimony_flutter/launch_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.emailVerified) {
            return NameProfilephoto();
          } else {
            return VerifyEmailAddress();
          }
        } else {
          return LaunchPage();
        }
      },
    );
  }
}
