import 'package:flutter/material.dart';
import 'package:taro/constants.dart';
import 'navigation_bar.dart';
import 'card_kit.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({Key? key}) : super(key: key);

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        actionsIconTheme: IconThemeData(
          size: 32,
          color: Theme.of(context).colorScheme.secondary,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
            splashRadius: 0.1,
          ),
        ],
      ),
      bottomNavigationBar: const MainNavigationBar(),
      backgroundColor:
          Theme.of(context).colorScheme.primaryContainer.withAlpha(150),
      body: const SessionBody(),
    );
  }
}

class SessionBody extends StatefulWidget {
  const SessionBody({Key? key}) : super(key: key);

  @override
  State<SessionBody> createState() => _SessionBodyState();
}

class CellLine {
  bool show = true;
  int length = 1;
  CellLine(this.show, this.length);
}


var testScheme = [
  [
    CellLine(true, 1),
    CellLine(false, 2),
    CellLine(true, 1),
  ],
  [
    CellLine(true, 4),
  ],
  [
    CellLine(true, 1),
    CellLine(false, 2),
    CellLine(true, 1),
  ],
  [
    CellLine(true, 4),
  ],
  [
    CellLine(false, 1),
    CellLine(true, 2),
  ],
];

class _SessionBodyState extends State<SessionBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: <Widget>[
          Container(
            width: screenWidth,
            height: MySize.cardHeight,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DraggableCard(thisCard: CardEntity(isOpen: false,)),
              ],
            ),
          ),
          Container(
            width: screenWidth,
            alignment: Alignment.topCenter,
            child: Column(
              children: (() {
                var scheme = <Widget>[];
                testScheme.forEach((rowNumbers) {
                  scheme.add(Row(
                    children: (() {
                      var lineWidgets = <Widget>[];
                      rowNumbers.forEach((line) {
                        lineWidgets.addAll(List<Widget>.filled(line.length, line.show ? Cell() : const EmptyCell()));
                      });
                      return lineWidgets;
                    } ())
                  ));
                });

                return scheme;
              }()),
            ),
          ),
        ],
      ),
    );
  }
}

