import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taro/constants.dart';

class MySize {
  static double cardWidth = screenWidth / 7.4;
  static double cardHeight = cardWidth * 4 / 3;
}

class CardEntity extends StatefulWidget {
  CardEntity({Key? key, this.isOpen = false}) : super(key: key);

  bool isOpen;

  @override
  State<CardEntity> createState() => _CardEntityState();
}

class _CardEntityState extends State<CardEntity> {
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

  final CardEntity? thisCard;

  @override
  State<DraggableCard> createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard> {

  @override
  Widget build(BuildContext context) {
    return Draggable(
      maxSimultaneousDrags: 1,

      data: widget.thisCard,

      feedback: widget.thisCard ?? CardEntity(),
      childWhenDragging: SizedBox(
        width: MySize.cardWidth,
        height: MySize.cardHeight,
      ),

      child: widget.thisCard ?? CardEntity(),
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
        onAccept: (CardEntity newCard){
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