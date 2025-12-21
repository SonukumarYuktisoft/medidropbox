import 'package:medidropbox/core/extensions/button_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class AppBackBtn extends StatelessWidget {
  const AppBackBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Icon(Icons.arrow_back,color: Colors.black,).asFilledButton(
      height: 30,width: 30,
      color: Colors.white,
      onPressed: ()=>AppNavigators.pop()).paddingOnly(left: 15));
  }
}