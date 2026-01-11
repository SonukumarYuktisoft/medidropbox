import 'package:medidropbox/core/extensions/button_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/utility/themes/app_theme.dart';

class UploadLabReportBtn extends StatelessWidget {
  const UploadLabReportBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Row(
                children: [
                  const Icon(
                    Icons.upload_file_rounded,
                    color: Colors.white,
                    
                    size: 22,
                  ),
                 
              
                  const SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Upload Lab Report',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                   const Text(
                    'Upload Lab Report',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
        
        
                ],
              ),
              
                ],
              ),
            ),
          
          ],
        ).radiusContainer(
          padding: EdgeInsets.symmetric(horizontal: 15),
          margin: EdgeInsets.symmetric(horizontal: 15),
          height: 55,
          color: AppTheme.lightTheme.primaryColor.withAlpha(-30),
          radius: 12, // you can adjust or remove if your extension has default
        ),
      
        Positioned(
          top: 5.0,
          right: 5.0,
          child: "https://cdn-icons-png.flaticon.com/128/3596/3596029.png".toImage(
            fit: BoxFit.fitHeight
          ),
        )

      ],
    ).onTap((){
      AppNavigators.pushNamed(AppRoutesName.uploadLabReportView);
    });
  }
}