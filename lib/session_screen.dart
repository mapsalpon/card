import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taro/constants.dart';
import 'navigation_bar.dart';

class MySize {
  static double cardWidth = screenWidth / 7.4;
  static double cardHeight = cardWidth * 4 / 3;
}

class SessionPage extends StatefulWidget {
  const SessionPage({Key? key}) : super(key: key);

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  double cardWidth = screenWidth / 7.2;
  double cardRatio = 4 / 3;

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: screenWidth,
            height: cardWidth * cardRatio,
            color: Colors.black87,
            child: Row(
              children: [
                DraggableCard(thisCard: Card(isOpen: false,)),
                DraggableCard(thisCard: Card(isOpen: false,)),
                DraggableCard(thisCard: Card(isOpen: true,)),
                DraggableCard(thisCard: Card(isOpen: true,)),
                DraggableCard(thisCard: Card(isOpen: true,)),
                DraggableCard(thisCard: Card(isOpen: false,)),
              ],
            ),
          ),
          Container(
            width: screenWidth,
            alignment: Alignment.topCenter,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: (() {
                var listOfWidgets = <Widget>[];
                var inputWidgets = <Widget>[
                  Cell(),
                  Cell(),
                  Cell(),
                  Cell(),
                ];
                listOfWidgets.addAll(inputWidgets);
                return listOfWidgets;
              }()),
            ),
          ),
        ],
      ),
    );
  }
}

class Card extends StatefulWidget {
  Card({Key? key, this.isOpen = false}) : super(key: key);

  bool isOpen;

  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  Color cardFrontColor = Colors.white;
  Color cardBackColor = Colors.purple.shade900;
  int number = Random().nextInt(14);

  late BoxDecoration cardDecoration = BoxDecoration(
    color: cardFrontColor,
    borderRadius: BorderRadius.circular(6),
    border: Border.all(color: cardFrontColor, width: 4),
  );


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          widget.isOpen = !widget.isOpen;
        });
      },
      child: widget.isOpen
          ? Container(
        decoration: cardDecoration,
        width: MySize.cardWidth,
        height: MySize.cardHeight,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: cardFrontColor,
          ),
          child: Text(
            '${number}',
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
      )
          : Container(
        decoration: cardDecoration,
        width: MySize.cardWidth,
        height: MySize.cardHeight,
        child: Container(
          decoration: BoxDecoration(
            color: cardBackColor,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }
}

class DraggableCard extends StatefulWidget {
  DraggableCard({super.key, this.thisCard});

  final Card? thisCard;

  @override
  State<DraggableCard> createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard> {

  @override
  Widget build(BuildContext context) {
    return Draggable(
      maxSimultaneousDrags: 1,
      data: widget.thisCard,

      feedback: widget.thisCard ?? Card(),
      childWhenDragging: SizedBox(
        width: MySize.cardWidth,
        height: MySize.cardHeight,
      ),

      child: widget.thisCard ?? Card(),
    );
  }
}

class Cell extends StatefulWidget {
  const Cell({Key? key}) : super(key: key);

  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {

  Widget onShow = Container(
    width: MySize.cardWidth,
    height: MySize.cardHeight,
    decoration: BoxDecoration(
      color: Colors.purpleAccent.withOpacity(0.1),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
          color: Colors.purple.withOpacity(0.3),
          width: 4),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onAccept: (Card newCard){
        setState(() {
          onShow = newCard;
        });
      },
        builder:
        (BuildContext context, List<dynamic> accepted, List<dynamic> rejected) {
      return onShow;
    });
  }
}
