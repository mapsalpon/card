import 'dart:math';

import 'package:flutter/material.dart';
import 'constants.dart';
import 'navigation_bar.dart';

class DailyEventPage extends StatefulWidget {
  const DailyEventPage({Key? key}) : super(key: key);

  @override
  State<DailyEventPage> createState() => _DailyEventPageState();
}

class _DailyEventPageState extends State<DailyEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
        title: Text(
          'Ежедневные испытания',
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
            icon: const Icon(Icons.info_outline),
            splashRadius: 0.1,
          ),
        ],
      ),
      bottomNavigationBar: MainNavigationBar(),
      body: Column(
        children: const <Widget>[
          MonthlyAward(),
          CalendarOfEvent(),
          PlayEventButton(),
        ],
      ),
    );
  }
}

class MonthlyAward extends StatefulWidget {
  const MonthlyAward({Key? key}) : super(key: key);

  @override
  State<MonthlyAward> createState() => _MonthlyAwardState();
}

class _MonthlyAwardState extends State<MonthlyAward> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 8,
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: 300,
              height: 250,
              color: Colors.grey,
              child: const AwardAnimatedParticles(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              color: Colors.transparent,
              width: 150,
              height: 250,
              child: Image(image: AssetImage('asset_bundle/images/award-cup.png'), color: Colors.black54,),
          ),
          ]
        ),
      ),
    );
  }
}

class AwardAnimatedParticles extends StatefulWidget {
  const AwardAnimatedParticles({Key? key}) : super(key: key);

  @override
  State<AwardAnimatedParticles> createState() => _AwardAnimatedParticlesState();
}

class _AwardAnimatedParticlesState extends State<AwardAnimatedParticles> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<double> _yAxisAlignment;
  late final Animation<double> _xAxisAlignment;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3), reverseDuration: const Duration(seconds: 3))..repeat(reverse: true,);

    _xAxisAlignment = Tween<double>(
      begin: -1,
      end: 1,
    ).animate(_controller);

    _yAxisAlignment = Tween<double>(
      begin: -pi,
      end: pi,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {

    double yAxisAlignmentValue = cos(_yAxisAlignment.value);

    return SizedBox(
      width: 300,
      height: 200,
      child: AnimatedBuilder(
        animation: _xAxisAlignment,
        builder: (context, child) {
          return Align(
          alignment: Alignment(_xAxisAlignment.value, _yAxisAlignment.value),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
              shape: BoxShape.circle,
            ),
          ),
        );
        }
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}


class CalendarOfEvent extends StatefulWidget {
  const CalendarOfEvent({Key? key}) : super(key: key);

  @override
  State<CalendarOfEvent> createState() => _CalendarOfEventState();
}

class _CalendarOfEventState extends State<CalendarOfEvent> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 9,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
        child: const CalendarScaffold(),
      ),
    );
  }
}

class CalendarScaffold extends StatefulWidget {
  const CalendarScaffold({Key? key}) : super(key: key);

  @override
  State<CalendarScaffold> createState() => _CalendarScaffoldState();
}

class _CalendarScaffoldState extends State<CalendarScaffold> {
  TextStyle statisticTextStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );

  Widget weekDay(String dayName) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      width: screenWidth / 12,
      child: Text(
        dayName,
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Март 2023',
                  style: statisticTextStyle,
                ),
                Row(
                  children: [
                    const Icon(Icons.image_outlined),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      '15/31',
                      style: statisticTextStyle,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                weekDay('Пн'),
                weekDay('Вт'),
                weekDay('Ср'),
                weekDay('Чт'),
                weekDay('Пт'),
                weekDay('Сб'),
                weekDay('Вс'),
              ],
            ),
            SizedBox(
              height: screenHeight / 4.4,
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14),
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: (() {
                  List<EventPreview> debugList = [];
                  for (var e = 0; e < List.filled(Random().nextInt(6), null).length; e++) {
                    debugList.add(EventPreview(isDone: null,));
                  }
                  for (var i = 1; i < 31; i++) {
                    debugList.add(EventPreview(isDone: ([true, false]..shuffle()).first, day: i,));
                  }
                  
                  return debugList;
                }()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventPreview extends StatefulWidget {
  EventPreview({Key? key, this.isDone, this.day}) : super(key: key);

  bool? isDone;
  int? day;

  @override
  State<EventPreview> createState() => _EventPreviewState();
}

class _EventPreviewState extends State<EventPreview> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        child: (() {
          switch (widget.isDone) {
            case null:
              return SizedBox();
            case true:
              return Container(
                color: Colors.purple,
                width: 100,
                height: 100,
              );
            case false:
              return Text(
                '${widget.day}',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              );
          }
        }()));
  }
}

class PlayEventButton extends StatelessWidget {
  const PlayEventButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: screenWidth,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24, right: 24, left: 24),
        child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            minimumSize: const MaterialStatePropertyAll(Size(0, 50)),
            backgroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.secondaryContainer),
            elevation: MaterialStatePropertyAll(10),
            shadowColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.primaryContainer),
          ),
          child: const Text(
            'Играть',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
