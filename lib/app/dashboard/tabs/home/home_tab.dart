import 'package:medidropbox/app/dashboard/tabs/home/widget/available_doctors.dart';
import 'package:medidropbox/app/dashboard/tabs/home/widget/banner_card.dart';
import 'package:medidropbox/app/dashboard/tabs/home/widget/my_lab_reports.dart';
import 'package:medidropbox/app/dashboard/tabs/home/widget/upload_lab_report_btn.dart';
import 'package:medidropbox/app/dashboard/tabs/home/widget/hospital_card.dart';
import 'package:medidropbox/app/dashboard/tabs/home/widget/my_queue_card.dart';
import 'package:medidropbox/app/views/health_profile/health_widget/health_profile_card.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            UploadLabReportBtn(),
            15.heightBox,
            // Health Profile Section - NEW
           // HealthProfileCard(isNavigate: true),
          //  15.heightBox,
            
            // // Vitals History - NEW
            // VitalsHistoryCard(),
            // 15.heightBox,




          //  MyLabReports(),
            //15.heightBox,
            BannerCard(),
            15.heightBox,
            MyQueueCard(),
            
            HospitalCard(),
            10.heightBox,
            AvailableDoctors(),
          ],
        ),
      ),
    );
  }
}




class VitalsHistoryCard extends StatelessWidget {
  const VitalsHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Vitals',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to full vitals history page
                },
                child: Text('View All'),
              ),
            ],
          ),
          SizedBox(height: 12),
          
          // Latest Vital Records
          _buildVitalItem(
            icon: Icons.favorite,
            title: 'Blood Pressure',
            value: '120/80 mmHg',
            time: '2 hours ago',
            color: Colors.red,
          ),
          Divider(height: 20),
          _buildVitalItem(
            icon: Icons.monitor_weight,
            title: 'Weight',
            value: '70 kg',
            time: '1 day ago',
            color: Colors.blue,
          ),
          Divider(height: 20),
          _buildVitalItem(
            icon: Icons.height,
            title: 'Height',
            value: '175 cm',
            time: '3 days ago',
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildVitalItem({
    required IconData icon,
    required String title,
    required String value,
    required String time,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 2),
              Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}



