import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:intl/intl.dart'; //가격

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SalesData>? _chartData;
  TooltipBehavior? _tooltipBehavior;
  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SfCartesianChart(
          title: ChartTitle(
              text: 'Yearly sales analysis'), //타이틀 넣기, 배경색,배열,보더컬러,텍스트스타일도 가능
          legend: Legend(isVisible: true), //범례 표시
          tooltipBehavior: _tooltipBehavior,
          series: <ChartSeries>[
            LineSeries<SalesData, double>(
                name: 'Sales', //범례 이름 바꾸기
                dataSource: _chartData!,
                xValueMapper: (SalesData sales, _) => sales.year, //x축 값
                yValueMapper: (SalesData sales, _) => sales.sales, //y축 값
                dataLabelSettings: DataLabelSettings(isVisible: true),
                enableTooltip: true //포인트에 값 표시
                ),
          ],
          primaryXAxis: NumericAxis(
              edgeLabelPlacement:
                  EdgeLabelPlacement.shift), //edge에 있는 라벨을 옮긴다(잘리는거)
          primaryYAxis: NumericAxis(
              labelFormat: '{value}M',
              numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
              edgeLabelPlacement: EdgeLabelPlacement.shift), //intl 적용해 달러로 표시
        ),
      ),
    );
  }

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData(2017, 25),
      SalesData(2018, 12),
      SalesData(2019, 24),
      SalesData(2020, 18),
      SalesData(2021, 30),
    ];
    return chartData;
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final double year;
  final double sales;
}
