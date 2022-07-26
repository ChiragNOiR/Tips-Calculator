import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = TextEditingController();
  List<bool> _selection = [true, false, false];

  dynamic tip;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (tip != null)
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  tip,
                  style: TextStyle(fontSize: 30),
                ),
              ),
            Text('Total Amount'),
            SizedBox(
              width: 75,
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                decoration: InputDecoration(hintText: '\$100.00'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ToggleButtons(
                children: [Text('10%'), Text('15%'), Text('20%')],
                isSelected: _selection,
                onPressed: updateSelection,
              ),
            ),
            RaisedButton(
              onPressed: calculateTip,
              child: Text('Calculate Tip'),
              color: Colors.green,
              textColor: Colors.white,
            )
          ],
        ),
      )),
    );
  }

  void updateSelection(int selectedIndex) {
    setState(() {
      for (int i = 0; i < _selection.length; i++) {
        _selection[i] = selectedIndex == i;
      }
    });
  }

  void calculateTip() {
    final totalAmount = double.parse(
        controller.text); //parsing the user amount into type double
    final selectedIndex = _selection.indexWhere((element) =>
        element); //loop from selection to get index where it is true, checking first element if its true
    final tipPercentatge = [
      0.1,
      0.15,
      0.2
    ][selectedIndex]; // tip percent equals to decimal, where 10% = 0.1%,

    final tipTotal = (totalAmount * tipPercentatge).toStringAsFixed(2);

    setState(() {
      tip = '\$$tipTotal';
    });
  }
}
