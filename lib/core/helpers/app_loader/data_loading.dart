
import 'package:medidropbox/core/extensions/container_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class DataLoading extends StatelessWidget {
  final Color? bgColor;
  final double? pading;
  final Color? loaderColor;
  final double? size;
  final Widget? child;
  final double? margin;
  const DataLoading({
    super.key,
    this.bgColor,
    this.pading,
    this.loaderColor,
    this.size,
    this.margin,
    this.child,
  });

  @override
  Widget build(BuildContext context) => Center(
    child: Stack(
      alignment: Alignment(
        MediaQuery.of(context).size.width % 2,
        MediaQuery.of(context).size.height % 2,
      ),
      children: [
        CircularProgressIndicator(
          strokeCap: StrokeCap.round,
          color: loaderColor ?? Colors.white,
        ).circularContainer(
          size: size ?? 30,
          padding: EdgeInsets.all(pading ?? 5),
          margin: EdgeInsets.all(margin ?? 0),
          color: bgColor ?? Theme.of(context).colorScheme.primary
        ),
        SizedBox(child: child),
      ],
    ),
  );
}
