import 'package:flutter/material.dart';

class D59ExplicitAnimations extends StatefulWidget {
  const D59ExplicitAnimations({super.key});

  @override
  State<D59ExplicitAnimations> createState() => _D59ExplicitAnimationsState();
}

class _D59ExplicitAnimationsState extends State<D59ExplicitAnimations>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2000),
  )
    ..forward()
    ..repeat();
  // ..repeat(reverse: true);

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          alignment: Alignment.bottomCenter,
          child: GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5),
            reverse: true,
            itemCount: 25,
            itemBuilder: (context, index) {
              final row = index ~/ 5;
              if (row % 2 == 0) {
                index = row * 5 + 4 - (index % 5);
              }
              print("index $index / row $row");
              final appearAnimation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Interval(index / 100, (index + 25) / 100,
                      curve: Curves.elasticInOut),
                ),
              );
              final disappearAnimation =
                  Tween<double>(begin: 1.0, end: 0.0).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Interval(
                      25 / 100 + index / 100, 25 / 100 + (index + 50) / 100,
                      curve: Curves.elasticInOut),
                ),
              );

              return ScaleTransition(
                scale: disappearAnimation,
                child: FadeTransition(
                  opacity: disappearAnimation,
                  child: ScaleTransition(
                    scale: appearAnimation,
                    child: FadeTransition(
                      opacity: appearAnimation,
                      child: Container(
                        height: 60,
                        width: 60,
                        margin: const EdgeInsets.all(
                          15,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.red,
                        ),
                        /* child: Text(
                          "$index",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ), */
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
