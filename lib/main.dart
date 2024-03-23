import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:payback/data/repository/auth_repo.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/model/auth_response.dart';
import 'package:payback/providers/CommitmentsProvider.dart';
import 'package:payback/providers/checkout_provider.dart';
import 'package:payback/providers/help_community_provider.dart';
import 'package:payback/providers/home_provider.dart';
import 'package:payback/screens/invitation_screen.dart';

import 'dart:math' as math;

import 'package:payback/screens/splash.dart';

import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';

import 'data/http/urls.dart';
import 'data/preferences.dart';
import 'data/service_locator.dart';
import 'providers/auth_provider.dart' as a;


bool _initialURILinkHandled = false;

bool hasInvitation = false;

StreamSubscription? _streamSubscription;

Future<void> _initURIHandler() async {
  // 1
  if (!_initialURILinkHandled) {
    _initialURILinkHandled = true;
    // 2

    try {
      // 3
      final initialURI = await getInitialUri();
      // 4
      if (initialURI != null) {
        debugPrint("Initial URI received $initialURI with id ${initialURI.queryParameters.toString()}");

        sl<PreferenceUtils>().saveInvitation(initialURI.toString());



      } else {
        debugPrint("Null Initial URI received");
      }
    } on PlatformException { // 5
      debugPrint("Failed to receive initial uri");
    } on FormatException catch (err) { // 6

    }
  }
}

void _incomingLinkHandler() {
  // 1
  if (!kIsWeb) {
    // 2
    _streamSubscription = uriLinkStream.listen((Uri? uri) {

      debugPrint('Received URI: $uri');

      if(uri!=null) {
        sl<PreferenceUtils>().saveInvitation(uri.toString());
        if (sl.isRegistered<AuthResponse>()) {
          Get.to(InvitationScreen());
        }
      }





      // 3
    }, onError: (Object err) {

      debugPrint('Error occurred: $err');

    });
  }
}

void _configureFCMListeners() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Handle incoming data message when the app is in the foreground

    print("foreground Data message received: ${message.data}");
    // Extract data and perform custom actions
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // Handle incoming data message when the app is in the background or terminated
    print("background Data message opened: ${message.data}");

    // Extract data and perform custom actions
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


}

void _initializeFCM() {
  FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.instance.getToken().then((token) {
    print("FCM Token: $token");


    Future.delayed(Duration.zero).then((value){
      if(sl.isRegistered<AuthResponse>()&&sl.isRegistered<AuthRepository>()){
        if(token!=null){
          sl<AuthRepository>().sendFCMToken({'token':token});

        }
      }
    });
    // Store the token on your server for sending targeted messages
  });
}

bool hasNotification = false;
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.data.toString()}");

  /*init();

  sl<PreferenceUtils>().saveNotification();*/
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  _initializeFCM();

  await init();
  final  user = FirebaseAuth.instance.currentUser;
  final uid = user?.uid;

  print('uid ${uid}');
  //sl<PreferenceUtils>().readNotification().then((value) => print('notifications main app is ${value}'));

  _configureFCMListeners();


  AuthResponse? loginModel = await sl<PreferenceUtils>().readUser();

  if (loginModel != null) {
    sl.registerSingleton(loginModel);
    Url.TOKEN = loginModel.data!.token!;


  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<a.AuthProvider>(create: (_) => a.AuthProvider()),
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
        ChangeNotifierProvider<CheckoutProvider>(
            create: (_) => CheckoutProvider()),
        ChangeNotifierProvider<HelpCommunityProvider>(
            create: (_) => HelpCommunityProvider()),
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
//AIzaSyAm_ZEJZ58IDAn9IjtGr3a9Y0UKKjOcWI0
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initURIHandler();
    _incomingLinkHandler();

  }

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
    this.onBranchClick,
    Key? key,
  })  : // make sure sum of data is never over 100 percent
        assert(data.fold<double>(0, (sum, data) => sum + data.percent) <= 100),
        super(key: key);

  final List<PieChartData> data;
  // Radius of chart
  final double radius;
  // Width of stroke
  final double strokeWidth;
  // Optional child; can be used for text for example
  final Widget? child;
  // Callback function for branch click
  final void Function(int)? onBranchClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (TapUpDetails details) {
        if (onBranchClick != null) {
          final RenderBox box = context.findRenderObject() as RenderBox;
          final Offset localPosition = box.globalToLocal(details.globalPosition);
          final double tapAngle = (math.atan2(localPosition.dy - radius, localPosition.dx - radius) + math.pi * 2) % (math.pi * 2);
          double cumulativePercent = 0;
          for (int i = 0; i < data.length; i++) {
            final double startAngle = math.pi * 2 * cumulativePercent / 100;
            final double endAngle = math.pi * 2 * (cumulativePercent + data[i].percent) / 100;
            print('Tap Angle: $tapAngle, Branch $i - Start Angle: $startAngle, End Angle: $endAngle'); // Debugging statement

            if (tapAngle >= startAngle && tapAngle <= endAngle) {
              onBranchClick!(i); // Call the callback with the index of the tapped branch
              break;
            }
            cumulativePercent += data[i].percent;
          }
        }
      },
      child: CustomPaint(
        painter: _Painter(strokeWidth, data),
        size: Size.square(radius),
        child: SizedBox.square(
          // Calculate diameter
          dimension: radius * 2,
          child: Center(
            child: child,
          ),
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
