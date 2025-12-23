// Generic reusable pagination loader widget
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medidropbox/core/helpers/app_loader/data_loading.dart';
import 'package:medidropbox/core/helpers/app_loader/no_more_data.dart';
import 'package:medidropbox/core/utility/const/app_enums.dart';

class AppPaginationLoader<B extends StateStreamable<S>, S>
    extends StatelessWidget {
  final ApiStatus Function(S state) getPageStatus;
  final bool showNoMore;
  final double? loadingSize;

  const AppPaginationLoader({
    super.key,
    required this.getPageStatus,
    this.showNoMore = false,
    this.loadingSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      // Fixed buildWhen - was comparing function to function
      buildWhen: (previous, current) =>
          getPageStatus(previous) != getPageStatus(current),
      builder: (context, state) {
        final pageStatus = getPageStatus(state);

        if (pageStatus == ApiStatus.loading) {
          return DataLoading(size: loadingSize!, margin: 5);
        }

        if (pageStatus == ApiStatus.error) {
          return showNoMore ? NoMoreData() : SizedBox.shrink();
        }

        return SizedBox.shrink();
      },
    );
  }
}
