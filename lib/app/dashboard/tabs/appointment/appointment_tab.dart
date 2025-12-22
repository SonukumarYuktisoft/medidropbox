import 'package:medidropbox/core/helpers/app_export.dart';

class AppointmentTab extends StatelessWidget {
  const AppointmentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          60.heightBox,
          const Text(
            "My Appointment",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          const TabBar(
            dividerColor: Colors.transparent,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: "Upcoming"),
              Tab(text: "Past"),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: TabBarView(
              children: [
                _AppointmentList(isUpcoming: true),
                _AppointmentList(isUpcoming: false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AppointmentList extends StatelessWidget {
  final bool isUpcoming;
  const _AppointmentList({required this.isUpcoming});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 4,
      itemBuilder: (context, index) {
        return AppointmentCard(isUpcoming: isUpcoming);
      },
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final bool isUpcoming;
  const AppointmentCard({super.key, required this.isUpcoming});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(
                flex: 3,
                child: _InfoItem(title: "Date", value: "03 August 2020"),
              ),
              Expanded(
                flex: 2,
                child: _InfoItem(title: "Time", value: "2:20 PM"),
              ),
              Expanded(
                flex: 3,
                child: _InfoItem(title: "Doctor", value: "Dr. Adam Smith"),
              ),
            ],
          ),

          16.heightBox,

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                flex: 3,
                child: _InfoItem(title: "Appointment Type", value: "Dentist"),
              ),
              const Expanded(
                flex: 2,
                child: _InfoItem(title: "Place", value: "New City Clinic"),
              ),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isUpcoming ? Colors.red : Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    child: Text(
                      isUpcoming ? "Cancel" : "Reschedule",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String title;
  final String value;

  const _InfoItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 6),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
