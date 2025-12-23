
import 'package:flutter/material.dart';
import 'package:medidropbox/core/helpers/app_loader/data_loading.dart';

Future showOverlayLoading(BuildContext context, {bool transParentBg = false}) =>
    showDialog(
      barrierDismissible: false,
      barrierColor: transParentBg ? Colors.transparent : null,
      context: context,
      builder: (context) => OverlayLoading(),
    );

class OverlayLoading extends StatefulWidget {
  const OverlayLoading({super.key});

  @override
  State<OverlayLoading> createState() => _OverlayLoadingState();
}

class _OverlayLoadingState extends State<OverlayLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: false,
    child: Dialog(
      backgroundColor: Colors.transparent,

      child: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) => Transform.scale(
            scale: _animation.value,
            child: DataLoading(
              size: 50,
              pading: 0,
              loaderColor: Theme.of(context).colorScheme.primary,
              bgColor:Colors.white,
              //child:CircularAssetImage(imageUrl: AppImages.appLogoPng,size: 47),
            ),
          ),
        ),
      ),
    ),
  );
}
