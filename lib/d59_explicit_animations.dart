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
    duration: const Duration(milliseconds: 1000),
  )
    ..forward()
    ..repeat(reverse: true);

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
          width: 250,
          height: 250,
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
              final animation = Tween(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Interval(index / 25, (index + 1) / 25,
                      curve: Curves.easeIn),
                ),
              );

              return AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Opacity(
                    opacity: animation.value,
                    child: Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.all(
                        10,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.red,
                      ),
                      child: Text(
                        "$index",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
