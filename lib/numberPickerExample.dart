import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NumberPicker Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'NumberPicker Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIntValue = 10;
  int _currentHorizontalIntValue = 10;
  int _currentInfIntValue = 10;
  int _currentInfIntValueDecorated = 10;
  double _currentDoubleValue = 3.0;
  NumberPicker integerNumberPicker;
  NumberPicker horizontalNumberPicker;
  NumberPicker integerInfiniteNumberPicker;
  NumberPicker integerInfiniteDecoratedNumberPicker;
  NumberPicker decimalNumberPicker;

  final Decoration _decoration = const BoxDecoration(
    border: Border(
      top: BorderSide(
        style: BorderStyle.solid,
        color: Colors.black26,
      ),
      bottom: BorderSide(
        style: BorderStyle.solid,
        color: Colors.black26,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    _initializeNumberPickers();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Integer'),
              Tab(text: 'Decimal'),
              Tab(text: 'Infinite loop'),
            ],
          ),
          title: Text(widget.title),
        ),
        body: TabBarView(
          children: [
            Column(
              children: <Widget>[
                const SizedBox(height: 16),
                Text('Default', style: Theme.of(context).textTheme.titleLarge),
                integerNumberPicker,
                MaterialButton(
                  onPressed: () => _showIntDialog(),
                  child: Text("Current int value: $_currentIntValue"),
                ),
                const Divider(color: Colors.grey, height: 32),
                Text('Horizontal',
                    style: Theme.of(context).textTheme.titleLarge),
                horizontalNumberPicker,
                Text(
                  "Current int value: $_currentHorizontalIntValue",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                decimalNumberPicker,
                MaterialButton(
                  onPressed: () => _showDoubleDialog(),
                  child: Text("Current double value: $_currentDoubleValue"),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                const SizedBox(height: 16),
                Text('Default', style: Theme.of(context).textTheme.titleLarge),
                integerInfiniteNumberPicker,
                MaterialButton(
                  onPressed: () => _showInfIntDialog(),
                  child: Text("Current int value: $_currentInfIntValue"),
                ),
                const Divider(color: Colors.grey, height: 32),
                Text('Decorated',
                    style: Theme.of(context).textTheme.titleLarge),
                integerInfiniteDecoratedNumberPicker,
                Text(
                  "Current int value: $_currentInfIntValueDecorated",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _initializeNumberPickers() {
    integerNumberPicker = NumberPicker.integer(
      initialValue: _currentIntValue,
      minValue: 0,
      maxValue: 100,
      step: 10,
      onChanged: (value) => setState(() => _currentIntValue = value),
    );
    horizontalNumberPicker = NumberPicker.horizontal(
      initialValue: _currentHorizontalIntValue,
      minValue: 0,
      maxValue: 100,
      step: 10,
      zeroPad: true,
      onChanged: (value) => setState(() => _currentHorizontalIntValue = value),
    );
    integerInfiniteNumberPicker = NumberPicker.integer(
      initialValue: _currentInfIntValue,
      minValue: 0,
      maxValue: 99,
      step: 10,
      infiniteLoop: true,
      onChanged: (value) => setState(() => _currentInfIntValue = value),
    );
    integerInfiniteDecoratedNumberPicker = NumberPicker.integer(
      initialValue: _currentInfIntValueDecorated,
      minValue: 0,
      maxValue: 99,
      step: 10,
      infiniteLoop: true,
      highlightSelectedValue: false,
      decoration: _decoration,
      onChanged: (value) =>
          setState(() => _currentInfIntValueDecorated = value),
    );
    decimalNumberPicker = NumberPicker.decimal(
      initialValue: _currentDoubleValue,
      minValue: 1,
      maxValue: 5,
      decimalPlaces: 2,
      onChanged: (value) => setState(() => _currentDoubleValue = value),
    );
  }

  Future _showIntDialog() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return NumberPickerDialog.integer(
          minValue: 0,
          maxValue: 100,
          step: 10,
          initialIntegerValue: _currentIntValue,
        );
      },
    ).then((num value) {
      setState(() => _currentIntValue = value);
      integerNumberPicker.animateInt(value);
    });
  }

  Future _showInfIntDialog() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return NumberPickerDialog.integer(
          minValue: 0,
          maxValue: 99,
          step: 10,
          initialIntegerValue: _currentInfIntValue,
          infiniteLoop: true,
        );
      },
    ).then((num value) {
      setState(() => _currentInfIntValue = value);
      integerInfiniteNumberPicker.animateInt(value);
    });
  }

  Future _showDoubleDialog() async {
    await showDialog<double>(
      context: context,
      builder: (BuildContext context) {
        return NumberPickerDialog.decimal(
          minValue: 1,
          maxValue: 5,
          decimalPlaces: 2,
          initialDoubleValue: _currentDoubleValue,
          title: const Text("Pick a decimal number"),
        );
      },
    ).then((num value) {
      setState(() => _currentDoubleValue = value);
      decimalNumberPicker.animateDecimalAndInteger(value);
    });
  }
}
