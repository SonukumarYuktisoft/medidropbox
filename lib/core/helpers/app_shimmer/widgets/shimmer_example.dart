
import 'package:flutter/material.dart';
import 'package:medidropbox/core/helpers/app_shimmer/app_shimmers.dart';

class ExampleUsage extends StatefulWidget {
  const ExampleUsage({super.key});
  @override
    State<ExampleUsage> createState() => _ExampleUsageState();

}

class _ExampleUsageState extends State<ExampleUsage> {
  bool isLoading = true;

  Widget _buildTopRowItem() {
    return ShimmerLoading(
      isLoading: isLoading,
      child: ShimmerPlaceholders.rectangularShimmer(
        width: 50,
        height: 50,
        borderRadius: 8,
      ),
    );
  }

  Widget _buildListTile() {
    return ShimmerLoading(
      isLoading: isLoading,
      child: ListTile(
        leading: ShimmerPlaceholders.circularShimmer(radius: 25),
        title: ShimmerPlaceholders.textShimmer(width: 150, height: 16),
        subtitle: ShimmerPlaceholders.textShimmer(width: 100, height: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shimmer Example'),
        actions: [
          IconButton(
            icon: Icon(isLoading ? Icons.stop : Icons.play_arrow),
            onPressed: () {
              setState(() {
                isLoading = !isLoading;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTopRowItem(),
                _buildTopRowItem(),
                _buildTopRowItem(),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: _buildListTile(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
