


import 'package:medidropbox/app/services/shared_preferences_helper.dart';
import 'package:medidropbox/core/extensions/button_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/navigator/routes/app_routes/app_routes_path.dart';

void showLogoutDialog(BuildContext context){
   showDialog(
      context: context,
      builder: (context) => LogoutConfirmationDialog(),
    );
}


class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: "Logout".toHeadingText(fontWeight: FontWeight.bold),
      content: 'Are you sure you want to logout?'.toHeadingText(
        fontWeight: FontWeight.w400,
        color:Colors.black,
        fontSize: 15,
      ),
      actions: [
     
         "Cancel".toHeadingText().asRoundedButton(
          backgroundColor:  Colors.grey,
          onPressed: () {
           Navigator.of(context).pop();
         },),
          "LogOut".toHeadingText().asRoundedButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
          SharedPreferencesHelper.logoutAndResetApp().whenComplete((){
            AppNavigators.go(AppRoutesPath.login);
          });
         },),
      
      ],
    );
  }
}
