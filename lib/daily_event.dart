import 'dart:math';
import 'dart:ui';

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,

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
      bottomNavigationBar: const MainNavigationBar(),
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
      flex: 9,
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: screenWidth,
              height: 300,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(color: Colors.black87, offset: Offset(0, 288), blurRadius: 50, spreadRadius: 10),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                  children: ((){
                    List<Widget> particleList = [
                      const AnimatedParticle(particleSize: 5, secondsPerLoop: 14, radius: 250,),
                      const AnimatedParticle(particleSize: 4, secondsPerLoop: 15, radius: 250,),
                      const AnimatedParticle(particleSize: 24, secondsPerLoop: 26, radius: 240,),
                    ];

                    for (var i = 1; i <= 12; i++) {
                      particleList.add(
                        AnimatedParticle(
                          particleSize: Random().nextInt(50) + 3,
                          secondsPerLoop: Random().nextInt(30) + 30,
                          radius: Random().nextInt(140) + 100,
                        )
                      );
                    };

                    return particleList;
                  }())
              ),
            ),
            Container(
              height: 250,
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Image(image: AssetImage('asset_bundle/images/tree-leafless.png'), color: Colors.black.withOpacity(0.8), fit: BoxFit.fitHeight, height: 500,),
          ),
          ]
        ),
      ),
    );
  }
}

class AnimatedParticle extends StatefulWidget {
  const AnimatedParticle({Key? key, this.particleSize = 20, this.secondsPerLoop = 10, this.radius}) : super(key: key);

  final double particleSize;
  final int secondsPerLoop;

  ///Если значение не указано - область занимает размер своего родителя
  final double? radius;

  @override
  State<AnimatedParticle> createState() => _AnimatedParticleState();
}

class _AnimatedParticleState extends State<AnimatedParticle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<double> _coordinatesHandler;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: widget.secondsPerLoop))..repeat();

    _coordinatesHandler = Tween<double>(
      begin: -pi,
      end: pi,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    double randomShift = Random().nextDouble() * 2 * pi;
    double particleOpacity = Random().nextDouble();


    return AnimatedBuilder(
      animation: _coordinatesHandler,
      builder: (context, child) {
        return SizedBox(
          width: widget.radius,
          height: widget.radius,
          child: Align(
          alignment: Alignment(cos(_coordinatesHandler.value + randomShift), sin(_coordinatesHandler.value + randomShift)),
          child: Container(
            width: widget.particleSize,
            height: widget.particleSize,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(particleOpacity),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(blurRadius: 40, color: Theme.of(context).colorScheme.primary, spreadRadius: 12),
              ],
            ),
          ),
      ),
        );
      }
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
      flex: 8,
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
        padding: const EdgeInsets.only(left: 36, right: 36, top: 18),
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
              height: screenHeight/3.4,
              child: GridView(
                physics: const ClampingScrollPhysics(),
                clipBehavior: Clip.antiAlias,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                ),
                padding: const EdgeInsets.only(top: 8),
                children: (() {
                  List<EventPreview> debugList = [];
                  for (var e = 0; e < List.filled(Random().nextInt(7), null).length; e++) {
                    debugList.add(EventPreview(isDone: null,));
                  }
                  for (var i = 1; i <= 31; i++) {
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
              return const SizedBox();
            case true:
              return Container(
                color: Theme.of(context).colorScheme.secondaryContainer,
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
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.only(bottom: 6, right: 24, left: 24),
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
