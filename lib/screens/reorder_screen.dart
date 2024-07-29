import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:payback/helpers/colors.dart';
import 'package:payback/helpers/custom_widgets.dart';
import 'package:payback/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:payback/model/commitment_model.dart' as c;

class ReorderScreen extends StatefulWidget {
  const ReorderScreen({super.key});

  @override
  State<ReorderScreen> createState() => _ReorderScreenState();
}

class _ReorderScreenState extends State<ReorderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reorder'),centerTitle: true,actions: [
        InkWell(child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(Icons.save,color: kPurpleColor,),
        ),onTap: (){
          Provider.of<HomeProvider>(context,listen: false).reOrderCommitments().then((value){
            Get.snackbar('Alert', value['message'],backgroundColor: value['data']?Colors.green:Colors.red,colorText: Colors.white);
          });
        },)
      ],),
      body: Consumer<HomeProvider>(
        builder:(context, value, child) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: value.isLoading?Center(child: CircularProgressIndicator(),):Column(
            children: [
              Text('Long click and drag commitment to reorder',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,),
              Expanded(
                child: ReorderableListView(
                  onReorderStart: (_) {
                    FocusScope.of(context).unfocus();
                  },
                  children: value.commitments.asMap().entries.map((entry) {
                    int index = entry.key;
                    c.Commitment item = entry.value;
                    return ReorderableDelayedDragStartListener(
                      index: index,
                      key: ValueKey(item), // Use ValueKey with unique item
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        child: Commitment(key: Key("$index"), commitment: item),
                      ),
                    );
                  }).toList(),
                  onReorder: (int start, int current) {

                    // dragging from top to bottom
                    if (start < current) {
                      int end = current - 1;
                      c.Commitment startItem = value.commitments[start];
                      int i = 0;
                      int local = start;
                      do {
                        value.commitments[local] = value.commitments[++local];
                        i++;
                      } while (i < end - start);
                      value.commitments[end] = startItem;
                    }
                    // dragging from bottom to top
                    else if (start > current) {
                      c.Commitment startItem = value.commitments[start];
                      for (int i = start; i > current; i--) {
                        value.commitments[i] = value.commitments[i - 1];
                      }
                      value.commitments[current] = startItem;
                    }

                    value.notifyListeners();

                    setState(() {});
                  },

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
