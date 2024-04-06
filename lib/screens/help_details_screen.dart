
import 'package:flutter/material.dart';
import 'package:payback/helpers/custom_widgets.dart';
import 'package:payback/providers/CommitmentsProvider.dart';
import 'package:provider/provider.dart';

import '../helpers/colors.dart';

class HelpDetailsScreen extends StatefulWidget {
  const HelpDetailsScreen({super.key});

  @override
  State<HelpDetailsScreen> createState() => _HelpDetailsScreenState();
}

class _HelpDetailsScreenState extends State<HelpDetailsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value) => getFromToCommitments());
  }


  getFromToCommitments(){
    Provider.of<CommitmentsProvider>(context,listen: false).getFromToCommitments('send');
    Provider.of<CommitmentsProvider>(context,listen: false).getFromToCommitments('rserved');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/auth_background.png',
                ),
                fit: BoxFit.cover)),
        padding: EdgeInsets.all(16),
        child: Consumer<CommitmentsProvider>(
          builder:(context, value, child) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: kPurpleColor,
                        ),
                        label: Text(
                          'Back',
                          style: TextStyle(color: kPurpleColor),
                        )),

                    Text('Delete user',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 15),)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CircleAvatar(backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVR9V1Ix26V2s_WWWryH3FU5Qkl2yR4PL3BcUybf2cUw&s',),radius: 70,)
                ,SizedBox(height: 20,),
                Text('Karim Lamasso-Obligato',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                SizedBox(height: 25,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('You sharing to',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                  Text('Total 20%',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: kBlueColor),),

                ],),
                SizedBox(height: 10,),
                Column(children: List.generate(value.toUserCommitments.length, (index) => Container(margin:EdgeInsets.symmetric(vertical: 4),child: Commitment(commitment: value.toUserCommitments[index],))),)
               ,
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('Total shared 80%',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: kBlueColor),),
                  ],
                ),

                SizedBox(height: 25,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('You receiving to',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                  Text('Total 20%',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: kBlueColor),),

                ],),
                SizedBox(height: 10,),
                Column(children: List.generate(value.fromUserCommitments.length, (index) => Container(margin:EdgeInsets.symmetric(vertical: 4),child: Commitment(commitment: value.fromUserCommitments[index],))),)
                ,SizedBox(height: 10,),
                Row(
                  children: [
                    Text('Total received 80%',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: kBlueColor),),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
