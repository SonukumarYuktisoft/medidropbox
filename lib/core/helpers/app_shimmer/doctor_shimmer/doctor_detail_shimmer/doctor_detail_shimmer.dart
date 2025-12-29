import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DoctorDetailShimmer extends StatelessWidget {
  const DoctorDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),
      body: CustomScrollView(
        slivers: [
          // App bar shimmer
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue.shade400, Colors.blue.shade700],
                  ),
                ),
                child: Center(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Content shimmer
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category and rating row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildShimmerBox(width: 80, height: 30),
                          _buildShimmerBox(width: 120, height: 20),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Name
                      _buildShimmerBox(width: 200, height: 24),
                      const SizedBox(height: 8),

                      // Title
                      _buildShimmerBox(width: 150, height: 16),
                      const SizedBox(height: 20),

                      // Stats row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatShimmer(),
                          _buildStatShimmer(),
                          _buildStatShimmer(),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Specialty section
                      _buildShimmerBox(width: 100, height: 18),
                      const SizedBox(height: 8),
                      _buildShimmerBox(width: 120, height: 32),
                      const SizedBox(height: 24),

                      // About section
                      _buildShimmerBox(width: 80, height: 18),
                      const SizedBox(height: 8),
                      _buildShimmerBox(width: double.infinity, height: 14),
                      const SizedBox(height: 4),
                      _buildShimmerBox(width: double.infinity, height: 14),
                      const SizedBox(height: 4),
                      _buildShimmerBox(width: 250, height: 14),
                      const SizedBox(height: 24),

                      // Expertise section
                      _buildShimmerBox(width: 100, height: 18),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(
                          4,
                          (index) => _buildShimmerBox(width: 80, height: 32),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Services section
                      _buildShimmerBox(width: 100, height: 18),
                      const SizedBox(height: 10),
                      ...List.generate(
                        3,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              _buildShimmerBox(width: 20, height: 20),
                              const SizedBox(width: 8),
                              _buildShimmerBox(width: 200, height: 14),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Languages section
                      _buildShimmerBox(width: 100, height: 18),
                      const SizedBox(height: 8),
                      _buildShimmerBox(width: 180, height: 14),
                      const SizedBox(height: 24),

                      // Fees section
                      _buildShimmerBox(width: double.infinity, height: 60),
                      const SizedBox(height: 12),
                      _buildShimmerBox(width: double.infinity, height: 60),
                      const SizedBox(height: 24),

                      // Contact section
                      _buildShimmerBox(width: 160, height: 18),
                      const SizedBox(height: 12),
                      _buildShimmerBox(width: double.infinity, height: 60),
                      const SizedBox(height: 12),
                      _buildShimmerBox(width: double.infinity, height: 60),
                      const SizedBox(height: 24),

                      // Hospital section
                      _buildShimmerBox(width: 100, height: 18),
                      const SizedBox(height: 10),
                      _buildShimmerBox(width: double.infinity, height: 80),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerBox({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildStatShimmer() {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 6),
        _buildShimmerBox(width: 50, height: 16),
        const SizedBox(height: 2),
        _buildShimmerBox(width: 60, height: 12),
      ],
    );
  }
}