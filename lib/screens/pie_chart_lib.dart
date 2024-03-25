import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../helpers/colors.dart';
import '../model/cashback_dashboard.dart';

class PieChartSample2 extends StatefulWidget {
  PieChartSample2({super.key,required this.categories,required this.onTap});

  List<HistoryCategory> categories;
  Function onTap;

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1.3,
          child: Row(
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(

                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                           /* if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }*/
                            if(pieTouchResponse!=null){
                          if(pieTouchResponse.touchedSection!=null){
                            touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;

                            widget.onTap(touchedIndex);
                          }
                           }
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 50,
                      sections: showingSections(widget.categories),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
        CircleAvatar(radius: 50,backgroundColor: colors[touchedIndex%colors.length].withOpacity(.2),child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(touchedIndex!=-1)Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: colors[touchedIndex%colors.length],
              ),
              child: Text(
                '${widget.categories[touchedIndex].fromAll}%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(height: 4,),
            Container(
              child: Text(
                touchedIndex==-1?'Select section':'${widget.categories[touchedIndex].name}',
                style: TextStyle(color: colors[touchedIndex%colors.length], fontSize: 12),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              width: 70,
            ),
          ],
        ),)
      ],
    );
  }

  List<PieChartSectionData> showingSections(List<HistoryCategory> cats) {
    return List.generate(cats.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 55.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        color: colors[i%colors.length],
        value: cats[i].fromAll.toDouble(),
        title: '',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: colors[i%colors.length],
          shadows: shadows,
        ),
      );
    });
  }
}