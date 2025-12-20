import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Line
              Container(
                width: 200,
                height: 20,
                color: Colors.white,
              ),
              const SizedBox(height: 20),

              // List Shimmer
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          // Left box (image shimmer)
                          Container(
                            width: 60,
                            height: 60,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 16),

                          // Right side lines
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 14,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  width: 150,
                                  height: 14,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
