import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/providers/CommitmentsProvider.dart';
import 'package:payback/providers/checkout_provider.dart';
import 'package:payback/providers/home_provider.dart';
import 'package:payback/screens/checkout_screen.dart';
import 'package:payback/screens/commitment_category_received.dart';
import 'package:payback/screens/commitment_category_spent_screen.dart';
import 'package:payback/screens/commitments_details_another_screen.dart';
import 'package:payback/screens/commitments_screen.dart';
import 'package:payback/screens/commitmetn_details_screen.dart';
import 'package:payback/screens/contributer_screen.dart';
import 'package:payback/screens/email.dart';
import 'package:payback/screens/filter_products.dart';
import 'package:payback/screens/history_screen.dart';
import 'package:payback/screens/home_screen.dart';
import 'package:payback/screens/login.dart';
import 'package:payback/screens/main_screen.dart';
import 'package:payback/screens/new_commitment_screen.dart';
import 'package:payback/screens/order_details_screen.dart';
import 'package:payback/screens/partner_details_screen.dart';
import 'package:payback/screens/partner_info_screen.dart';
import 'package:payback/screens/phonenumber.dart';
import 'package:payback/screens/product_details_screen.dart';
import 'package:payback/screens/register.dart';
import 'package:payback/screens/saved_screen.dart';
import 'package:payback/screens/shop_online_screen.dart';
import 'package:payback/screens/splash.dart';

import 'package:provider/provider.dart';

import '../data/service_locator.dart';
import '../providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
        ChangeNotifierProvider<CheckoutProvider>(
            create: (_) => CheckoutProvider()),
        ChangeNotifierProvider<CommitmentsProvider>(
            create: (_) => CommitmentsProvider()),
      ],
      child: GetMaterialApp(
        home: MyApp(),
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          appBarTheme: AppBarTheme(
            backgroundColor: kBackgroundColor,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: kBackgroundColor,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splash(),
    );
  }
}

///////////////////////////////////////////////////
class PieChartData {
  const PieChartData(this.color, this.percent);

  final Color color;
  final double percent;
}

// our pie chart widget
class PieChart extends StatelessWidget {
  PieChart({
    required this.data,
    required this.radius,
    this.strokeWidth = 40,
    this.child,
    Key? key,
  })  : // make sure sum of data is never ovr 100 percent
        assert(data.fold<double>(0, (sum, data) => sum + data.percent) <= 100),
        super(key: key);

  final List<PieChartData> data;
  // radius of chart
  final double radius;
  // width of stroke
  final double strokeWidth;
  // optional child; can be used for text for example
  final Widget? child;

  @override
  Widget build(context) {
    return CustomPaint(
      painter: _Painter(strokeWidth, data),
      size: Size.square(radius),
      child: SizedBox.square(
        // calc diameter
        dimension: radius * 2,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

// responsible for painting our chart
class _PainterData {
  const _PainterData(this.paint, this.radians);

  final Paint paint;
  final double radians;
}

class _Painter extends CustomPainter {
  _Painter(double strokeWidth, List<PieChartData> data) {
    // convert chart data to painter data
    dataList = data
        .map((e) => _PainterData(
              Paint()
                ..color = e.color
                ..style = PaintingStyle.stroke
                ..strokeWidth = strokeWidth,
              // ..strokeCap = StrokeCap.round,
              //..strokeCap = StrokeCap.square,
              // remove padding from stroke
              (e.percent - _padding) * _percentInRadians,
            ))
        .toList();
  }

  static const _percentInRadians = 0.062831853071796;
  static const _padding = 0;
  static const _paddingInRadians = _percentInRadians * _padding;
  // 0 radians is to the right, but since we want to start from the top
  // we'll use -90 degrees in radians
  static const _startAngle = -1.570796 + _paddingInRadians / 2;

  late final List<_PainterData> dataList;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    // keep track of start angle for next stroke
    double startAngle = _startAngle;

    for (final data in dataList) {
      final path = Path()..addArc(rect, startAngle, data.radians);

      startAngle += data.radians + _paddingInRadians;

      canvas.drawPath(path, data.paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
