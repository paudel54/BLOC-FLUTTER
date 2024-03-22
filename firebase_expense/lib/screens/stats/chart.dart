import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyChart extends StatefulWidget {
  const MyChart({super.key});

  @override
  State<MyChart> createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      mainBarData(),
    );
  }

// x value for the y-axis bar and y value is the total value to raise on bar
  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          color: Colors.blue.shade600,
          toY: y,
          width: 14,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 7,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(
        8,
        (i) {
          switch (i) {
            case 0:
              return makeGroupData(0, 4);
            case 1:
              return makeGroupData(1, 2);
            case 2:
              return makeGroupData(2, 3.5);
            case 3:
              return makeGroupData(3, 4);
            case 4:
              return makeGroupData(4, 3);
            case 5:
              return makeGroupData(5, 1);
            case 6:
              return makeGroupData(6, 5);
            case 7:
              return makeGroupData(7, 6);
            default:
              return throw Error();
          }
        },
      );

  BarChartData mainBarData() {
    return BarChartData(
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 38,
            getTitlesWidget: getTiles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitles,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      gridData: const FlGridData(show: false),
      barGroups: showingGroups(),
    );
  }

  Widget getTiles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;

    switch (value.toInt()) {
      case 0:
        text = const Text(
          '01',
          style: style,
        );
        break;
      case 1:
        text = const Text(
          '02',
          style: style,
        );
        break;
      case 2:
        text = const Text(
          '03',
          style: style,
        );
        break;
      case 3:
        text = const Text(
          '04',
          style: style,
        );
        break;
      case 4:
        text = const Text(
          '05',
          style: style,
        );
        break;
      case 5:
        text = const Text(
          '06',
          style: style,
        );
        break;
      case 6:
        text = const Text(
          '07',
          style: style,
        );
        break;
      case 7:
        text = const Text(
          '08',
          style: style,
        );
        break;
      default:
        text = const Text(
          '',
          style: style,
        );
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    String text;

    if (value == 0) {
      text = '1K';
    } else if (value == 2) {
      text = '2K';
    } else if (value == 3) {
      text = '3K';
    } else if (value == 4) {
      text = '4K';
    } else if (value == 5) {
      text = '5K';
    } else if (value == 6) {
      text = '6K';
    } else {
      return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
