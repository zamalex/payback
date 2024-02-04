import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/providers/home_provider.dart';
import 'package:payback/screens/commitments_screen.dart';
import 'package:provider/provider.dart';

import '../helpers/custom_widgets.dart';



class HomeScreen extends StatefulWidget {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _counter = 20;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value){
      Provider.of<HomeProvider>(context,listen: false).getCategories();
      Provider.of<HomeProvider>(context,listen: false).getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      body:  Container(
        padding: EdgeInsets.all(0),
        child: ListView(children: [
          Card(

            color: Colors.white,
            elevation:0,
             shadowColor: Colors.grey,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
             ),
             borderOnForeground: true,
             child:  Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                   children: [
                     Container(
                       decoration: BoxDecoration(
                         border: Border.all(color: Colors.white,width: 2),
                         borderRadius: BorderRadius.only(
                         topRight: Radius.circular(8),
                         bottomLeft: Radius.circular(8),
                         topLeft: Radius.circular(25),
                         bottomRight: Radius.circular(25),
                       ),),
                       child: ClipRRect(borderRadius: BorderRadius.only(
                         topRight: Radius.circular(8),
                         bottomLeft: Radius.circular(8),
                         topLeft: Radius.circular(25),
                         bottomRight: Radius.circular(25),
                       ),child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVR9V1Ix26V2s_WWWryH3FU5Qkl2yR4PL3BcUybf2cUw&s',fit: BoxFit.cover,width: 70,height: 70,)),),
                     SizedBox(width: 10,),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('Hello, Mustafa',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: kPurpleColor),)
                         ,SizedBox(height: 10,)
                         ,Container(padding:EdgeInsets.symmetric(horizontal: 8,vertical: 4),decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: kPurpleColor),child: Row(children: [Icon(Icons.notification_add_outlined,color: Colors.white,),Text('2 notifications',style: TextStyle(color: Colors.white),)],),)
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


       
         Padding(padding: EdgeInsets.all(10),child: Column(
           children: [
             SizedBox(height: 20,),
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

             SizedBox(height: 20,),
             Commitment(),
             SizedBox(height: 20,),
             Row(
               children: [
                 Expanded(child: Text('Product categories',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),
                 Text('Show all',style: TextStyle(color: kBlueColor,fontWeight: FontWeight.bold),),
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
                   return  Container(width:70,
                       margin: EdgeInsets.symmetric(horizontal: 8),
                     child: Column(
                       children: [
                         CircleAvatar(
                           backgroundColor: kBlueLightColor,
                           child: Image.network('https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png',width: 35,),
                           radius: 35,
                         ),
                         SizedBox(height: 8),
                         Text(

                           value.categories![i].name??'',
                           style: TextStyle(
                             overflow: TextOverflow.ellipsis,
                             color: kBlueColor,
                             fontSize: 12,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                       ],
                     ),
                   );
                 }),
               ),
             ),
             SizedBox(height: 20,),
             Row(
               children: [
                 Expanded(child: Text('Hot deals',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),
                 Text('Show all',style: TextStyle(color: kBlueColor,fontWeight: FontWeight.bold),),
                 Icon(Icons.arrow_forward,color: kBlueColor,)
               ],
             ),
             Text('Best deals from Payback partners that might be interesting to you'),
             SizedBox(height: 10,),
             Container(
               height: 300,
               width: double.infinity,
               child: ListView.builder(
                 scrollDirection: Axis.horizontal,
                 itemBuilder: (c,i){
                   return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       width: 170,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [

                           Container(
                             padding: EdgeInsets.all(8),
                             alignment: Alignment.topCenter,
                             width:170,
                             height:200 ,
                             decoration: BoxDecoration(image: DecorationImage(image: NetworkImage('https://cdn-images.buyma.com/imgdata/item/230807/0097589320/564300514/428.jpg',),fit: BoxFit.cover),borderRadius: BorderRadius.circular(15)),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Container(

                                   child: Text('Earn 100 SAR',style: TextStyle(fontSize:11,color: Colors.purple,),),
                                   padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),

                                   decoration:BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),),
                                 CircleAvatar(radius:15,child: Icon(Icons.battery_saver_rounded,color: Colors.blue,),backgroundColor: Colors.white,)
                               ],
                             ),
                           ),
                           SizedBox(height: 5,),
                           Text('Nike shop',style: TextStyle(color: Colors.grey,),overflow: TextOverflow.ellipsis,maxLines: 1,)
                           ,                Text('2000 SAR',style: TextStyle(color: Colors.purple,fontSize: 16),overflow: TextOverflow.ellipsis,maxLines: 1)
                           ,                Text('Snakers shoe women',style: TextStyle(color: Colors.grey),overflow: TextOverflow.ellipsis,maxLines: 1)

                         ],),
                     ),
                   );
                 },itemCount: 5,),
             ),
             SizedBox(height: 20,),
             Row(
               children: [
                 Expanded(child: Text('Suggested for you',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),
                 Text('Show all',style: TextStyle(color: kBlueColor,fontWeight: FontWeight.bold),),
                 Icon(Icons.arrow_forward,color: kBlueColor,)
               ],
             ),
             Text('Check products with best cashback percentage to cover your commitments'),
             SizedBox(height: 10,),
             Container(
               height: 300,
               width: double.infinity,
               child: ListView.builder(
                 scrollDirection: Axis.horizontal,
                 itemBuilder: (c,i){
                   return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       width: 170,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [

                           Container(
                             padding: EdgeInsets.all(8),
                             alignment: Alignment.topCenter,
                             width:170,
                             height:200 ,
                             decoration: BoxDecoration(image: DecorationImage(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuCxMPJwglskH6j6jQhCmJGqIr9kR6_iMPng&usqp=CAU'),fit: BoxFit.cover),borderRadius: BorderRadius.circular(15)),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Container(

                                   child: Text('Earn 100 SAR',style: TextStyle(fontSize:11,color: Colors.purple,),),
                                   padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),

                                   decoration:BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),),
                                 CircleAvatar(radius:15,child: Icon(Icons.battery_saver_rounded,color: Colors.blue,),backgroundColor: Colors.white,)
                               ],
                             ),
                           ),
                           SizedBox(height: 5,),
                           Text('Nike shop',style: TextStyle(color: Colors.grey,),overflow: TextOverflow.ellipsis,maxLines: 1,)
                           ,                Text('2000 SAR',style: TextStyle(color: Colors.purple,fontSize: 16),overflow: TextOverflow.ellipsis,maxLines: 1)
                           ,                Text('Snakers shoe women',style: TextStyle(color: Colors.grey),overflow: TextOverflow.ellipsis,maxLines: 1)

                         ],),
                     ),
                   );
                 },itemCount: 5,),
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