import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(213, 222, 240, 1),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Center(
                  child: Column(
                    children: [
                      Text('You'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                    ],
                  ),
                )),
                Expanded(
                    child: Center(
                  child: Column(
                    children: [
                      Text('You'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                      Text('1'),
                    ],
                  ),
                )),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
            Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Text('Defender'),
                    SizedBox(
                      height: 13,
                    ),
                    BodyPartButton(
                      bodyPart: BodyPart.head,
                      selected: defendingBodyPart == BodyPart.head,
                      bodyPartSetter: _selectDefendingPart,
                    ),
                    BodyPartButton(
                      bodyPart: BodyPart.torso,
                      selected: defendingBodyPart == BodyPart.torso,
                      bodyPartSetter: _selectDefendingPart,
                    ),
                    BodyPartButton(
                      bodyPart: BodyPart.legs,
                      selected: defendingBodyPart == BodyPart.legs,
                      bodyPartSetter: _selectDefendingPart,
                    ),
                  ],
                )),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Text('Defender'),
                    SizedBox(
                      height: 13,
                    ),
                    BodyPartButton(
                      bodyPart: BodyPart.head,
                      selected: attackingBodyPart == BodyPart.head,
                      bodyPartSetter: _selectAttackingPart,
                    ),
                    BodyPartButton(
                      bodyPart: BodyPart.torso,
                      selected: attackingBodyPart == BodyPart.torso,
                      bodyPartSetter: _selectAttackingPart,
                    ),
                    BodyPartButton(
                      bodyPart: BodyPart.legs,
                      selected: attackingBodyPart == BodyPart.legs,
                      bodyPartSetter: _selectAttackingPart,
                    ),
                  ],
                )),
                SizedBox(
                  width: 16,
                )
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    if (!_isAllBtnSelected()) {
                      return;
                    }

                    setState(() {
                      defendingBodyPart = null;
                      attackingBodyPart = null;
                    });
                  },
                  child: SizedBox(
                      height: 40,
                      child: ColoredBox(
                        color: _isAllBtnSelected()
                            ? Color.fromRGBO(0, 0, 0, 0.87)
                            : Colors.black38,
                        child: Center(
                          child: Text(
                            'GO',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      )),
                )),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  bool _isAllBtnSelected() {
    return !(defendingBodyPart == null || attackingBodyPart == null);
  }

  void _selectDefendingPart(final BodyPart value) {
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectAttackingPart(final BodyPart value) {
    setState(() {
      attackingBodyPart = value;
    });
  }
}

class BodyPart {
  final String name;
  const BodyPart._(this.name);

  static const head = BodyPart._('Head');
  static const torso = BodyPart._('Torso');
  static const legs = BodyPart._('legs');

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButton(
      {Key? key,
      required this.bodyPart,
      required this.selected,
      required this.bodyPartSetter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        child: SizedBox(
          height: 40,
          child: ColoredBox(
            color: selected
                ? const Color.fromRGBO(28, 121, 206, 1)
                : Colors.black38,
            child: Center(
              child: Text(bodyPart.name.toUpperCase()),
            ),
          ),
        ),
      ),
    );
  }
}
