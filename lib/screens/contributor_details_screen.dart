import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:payback/model/contributor_model.dart';

import '../helpers/colors.dart';
import '../helpers/custom_widgets.dart';
import 'commitments_details_another_screen.dart';

class ContributorDetailsScreen extends StatelessWidget {
  ContributorDetailsScreen({super.key,required this.contributorModel});
  ContributorModel contributorModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('User details'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          ContributorWidget(contributorModel: contributorModel,),
                          SizedBox(
                            height: 20,
                          ),


                            Text('Shared to commitment',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              child: Commitment(commitment: contributorModel.commitment,another: true,))

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
