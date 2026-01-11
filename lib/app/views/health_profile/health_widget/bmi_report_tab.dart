import 'package:medidropbox/app/models/health_profile/bmi_report_model.dart';
import 'package:medidropbox/app/views/health_profile/bloc/health_profile_bloc.dart';
import 'package:medidropbox/core/helpers/app_export.dart';


class BmiReportTab extends StatelessWidget {
  const BmiReportTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "BMI Reports",titleColor: Colors.white,leadColor: Colors.white,),
      body: BlocBuilder<HealthProfileBloc, HealthProfileState>(
        buildWhen: (previous, current) => previous.bmiStatus != current.bmiStatus,
        builder: (context, state) {
          if(state.bmiStatus==ApiStatus.loading){
            return DataLoading();
          }
           if(state.bmiStatus==ApiStatus.error){
            return RefreshView(
              onPressed: () => context.read<HealthProfileBloc>().add((OnBMIReportApi())),
            );
          }
           if(state.bmiStatus==ApiStatus.success){
            var data = state.bmiData;
            if(data==null){
              return DataNotFound();
            }
            return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // BMI Score Card
                _buildBmiScoreCard(data),
                const SizedBox(height: 16),
                
                // Stats Row
                Row(
                  children: [
                    Expanded(child: _buildStatCard('Height', '${data.heightCm} cm', Icons.height, Colors.blue)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildStatCard('Weight', '${data.weightKg} kg', Icons.monitor_weight, Colors.purple)),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Description Card
                _buildInfoCard(
                  title: 'Your Status',
                  content: data.bmiDescription.toString(),
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
                const SizedBox(height: 16),
                
                // Recommendation Card
                _buildInfoCard(
                  title: 'Health Recommendation',
                  content: data.healthRecommendation.toString(),
                  icon: Icons.lightbulb,
                  color: Colors.orange,
                ),
                const SizedBox(height: 16),
                
                // Inspirational Quote
                _buildQuoteCard(data.inspirationalQuote.toString()),
                const SizedBox(height: 16),
                
                // Disclaimer
                _buildDisclaimerCard(data.disclaimer.toString()),
              ],
            ),
          );
          }
         
          return SizedBox();
        },
      ),
    );
  }

  Widget _buildBmiScoreCard(BmiReportModel data) {
    final bmi = double.parse(data.bmi.toString());
    final category = data.bmiCategory.toString();
    
    Color getCategoryColor() {
      switch (category.toLowerCase()) {
        case 'underweight':
          return Colors.blue;
        case 'normal':
          return Colors.green;
        case 'overweight':
          return Colors.orange;
        case 'obese':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [getCategoryColor().withOpacity(0.1), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: getCategoryColor().withOpacity(0.3), width: 2),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'Your BMI',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                bmi.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: getCategoryColor(),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'kg/m²',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: getCategoryColor(),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              category,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String content,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteCard(String quote) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade400, Colors.blue.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const Icon(Icons.format_quote, color: Colors.white, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              quote,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisclaimerCard(String disclaimer) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: Colors.amber[700], size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              disclaimer,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}