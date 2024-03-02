import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:payback/data/preferences.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/model/auth_response.dart';
import 'package:payback/providers/home_provider.dart';
import 'package:payback/providers/auth_provider.dart' as authProvider;
import 'package:payback/screens/commitments_screen.dart';
import 'package:payback/screens/login.dart';
import 'package:payback/screens/my_profile_screen.dart';
import 'package:provider/provider.dart';


import '../data/service_locator.dart';
import '../helpers/custom_widgets.dart';



class HomeScreen extends StatefulWidget {

  Function shopAll;
   HomeScreen({super.key,required this.shopAll});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _counter = 20;

  AuthResponse? authResponse;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value){
      Provider.of<HomeProvider>(context,listen: false).getCategories();
      Provider.of<HomeProvider>(context,listen: false).getProducts(isHotDeals: true);
      Provider.of<HomeProvider>(context,listen: false).getProducts(isSuggested: true);
      if(sl.isRegistered<AuthResponse>()){
        Provider.of<HomeProvider>(context,listen: false).getCommitments();
        Provider.of<authProvider.AuthProvider>(context,listen: false).getNotifications();

      }

    });

       sl<PreferenceUtils>().readUser().then((value) {
         setState(() {
           authResponse = value;

         });

    });


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      body:  Container(
        padding: EdgeInsets.all(0),
        child: ListView(children: [

            InkWell(
            onTap: (){
              if(sl.isRegistered<AuthResponse>())
              Get.to(MyProfileScreen());
              else
                Get.to(LoginScreen());
            },
            child: Card(
              margin: EdgeInsets.zero,

              color: Colors.white,
              elevation:0,
               shadowColor: Colors.grey,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)),
               ),
               child:  Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: Row(
                     children: [
                       Container(
                         decoration: BoxDecoration(
                           color: kPurpleColor,
                           border: Border.all(color: Colors.white,width: 2),
                           borderRadius: BorderRadius.only(
                           topRight: Radius.circular(8),
                           bottomLeft: Radius.circular(8),
                           topLeft: Radius.circular(30),
                           bottomRight: Radius.circular(30),
                         ),),
                         child: ClipRRect(borderRadius: BorderRadius.only(
                           topRight: Radius.circular(8),
                           bottomLeft: Radius.circular(8),
                           topLeft: Radius.circular(25),
                           bottomRight: Radius.circular(25),
                         ),child: !sl.isRegistered<AuthResponse>()?Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Image.asset('assets/images/payback_logo.png',width: 62,height: 62,),
                         ):Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVR9V1Ix26V2s_WWWryH3FU5Qkl2yR4PL3BcUybf2cUw&s',fit: BoxFit.cover,width: 70,height: 70,)),),
                       SizedBox(width: 10,),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(!sl.isRegistered<AuthResponse>()?'Welcome, Login now':'Hello, ${authResponse==null?'Mustafa':authResponse!.data!.user!.name}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: kPurpleColor),)
                           ,SizedBox(height: 10,),
                           if(sl.isRegistered<AuthResponse>())

                           Container(padding:EdgeInsets.symmetric(horizontal: 8,vertical: 4),decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: kPurpleColor),child: Consumer<authProvider.AuthProvider>(builder:(context, value, child) => Row(children: [Icon(Icons.notification_add_outlined,color: Colors.white,),Text('${value.notifications.length} notifications',style: TextStyle(color: Colors.white),)],)),)
                         ],
                       ),

                       Expanded(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             Icon(Icons.arrow_forward)
                           ],
                         ),
                       )
                     ],
                   ),
               ),

               ),
          ),


       
         Padding(padding: EdgeInsets.all(10),child: Column(
           children: [
             if(sl.isRegistered<AuthResponse>())

               SizedBox(height: 20,),

             if(sl.isRegistered<AuthResponse>())

               InkWell(
               onTap: (){
                 Get.to(CommitmentsScreen());
               },
               child: Row(
                 children: [
                   Expanded(child: Text('Priority commitments',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),
                   Text('Show all',style: TextStyle(color: kBlueColor,fontWeight: FontWeight.bold),),
                   Icon(Icons.arrow_forward,color: kBlueColor,)
                 ],
               ),
             ),

             if(sl.isRegistered<AuthResponse>())

               SizedBox(height: 20,),
             if(sl.isRegistered<AuthResponse>())

               Consumer<HomeProvider>(builder:(c,v,cc)=> v.commitments.isEmpty?Container():Commitment(commitment: v.commitments.first,)),
             SizedBox(height: 20,),
             Row(
               children: [
                 Expanded(child: Text('Product categories',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),
                 InkWell(onTap:(){widget.shopAll();},child:Text('Show all',style: TextStyle(color: kBlueColor,fontWeight: FontWeight.bold),),),
                 Icon(Icons.arrow_forward,color: kBlueColor,)
               ],
             ),
             SizedBox(height: 10,),
             Consumer<HomeProvider>(
               builder:(context, value, child) => Container(
                 height: 100,
                 child: ListView.builder(
                     scrollDirection: Axis.horizontal,
                     itemCount:value.categories==null?0:value.categories!.length,itemBuilder: (c,i){
                   return  CategoryWidget(category: value.categories![i],isSelected: value.selectedHomeIndex==i,onTap: (){value.selectHomeIndex(i);},);
                 }),
               ),
             ),
             SizedBox(height: 20,),
             Row(
               children: [
                 Expanded(child: Text('Hot deals',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),
                 InkWell(onTap:(){widget.shopAll();},child: Text('Show all',style: TextStyle(color: kBlueColor,fontWeight: FontWeight.bold),)),
                 Icon(Icons.arrow_forward,color: kBlueColor,)
               ],
             ),
             Text('Best deals from Payback partners that might be interesting to you'),
             SizedBox(height: 10,),
             Consumer<HomeProvider>(
               builder:(c,v,child)=> Container(
                 height: 300,
                 width: double.infinity,
                 child: ListView.builder(
                   scrollDirection: Axis.horizontal,
                   itemBuilder: (c,i){
                     return ProductWidget(product: v.hotDealsProducts[i]);
                   },itemCount: v.hotDealsProducts.length,),
               ),
             ),
             SizedBox(height: 20,),
             Row(
               children: [
                 Expanded(child: Text('Suggested for you',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),
                 InkWell(onTap:(){widget.shopAll();},child:Text('Show all',style: TextStyle(color: kBlueColor,fontWeight: FontWeight.bold),)),
                 Icon(Icons.arrow_forward,color: kBlueColor,)
               ],
             ),
             Text('Check products with best cashback percentage to cover your commitments'),
             SizedBox(height: 10,),
             Consumer<HomeProvider>(
               builder:(c,v,cc)=> Container(
                 height: 300,
                 width: double.infinity,
                 child: ListView.builder(
                   scrollDirection: Axis.horizontal,
                   itemBuilder: (c,i){
                     return ProductWidget(product: v.suggestedProducts[i],);
                   },itemCount: v.suggestedProducts.length,),
               ),
             )

           ],
         ),)

        ],),
      ),
    );
  }
}

class RPSCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Layer 1

    path.moveTo(0, size.height * 0.0020000);
    path.lineTo(size.width * 0.0010000, size.height * 0.4000000);
    path.lineTo(size.width * 0.2490000, size.height * 0.4000000);
    path.quadraticBezierTo(
        size.width * 0.2802000, size.height * 0.4017000, size.width * 0.2802000, size.height * 0.3772000);
    path.quadraticBezierTo(
        size.width * 0.2924500, size.height * 0.3772000, size.width * 0.2980000, size.height * 0.3020000);
    path.lineTo(size.width * 0.2990000, size.height * 0.0020000);
    path.lineTo(0, size.height * 0.0020000);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1
    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(0, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.0020000);
    path_0.lineTo(size.width * 0.0010000, size.height * 0.4000000);
    path_0.lineTo(size.width * 0.2490000, size.height * 0.4000000);
    path_0.quadraticBezierTo(size.width * 0.2802000, size.height * 0.4017000, size.width * 0.2802000, size.height * 0.3772000);
    path_0.quadraticBezierTo(size.width * 0.2924500, size.height * 0.3772000, size.width * 0.2980000, size.height * 0.3020000);
    path_0.lineTo(size.width * 0.2990000, size.height * 0.0020000);
    path_0.lineTo(0, size.height * 0.0020000);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1
    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}