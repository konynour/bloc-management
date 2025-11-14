import 'dart:developer';
import 'package:bloc_exmaple/bloc/counter_bloc.dart';
import 'package:bloc_exmaple/bloc/counter_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

void main() {
  runApp(
    BlocProvider(create: (context) => CounterBloc(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  
  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }
  
  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F2027),
              Color(0xFF203A43),
              Color(0xFF2C5364),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Animated Background Orbs
              ...List.generate(3, (index) {
                return AnimatedBuilder(
                  animation: _rotationController,
                  builder: (context, child) {
                    return Positioned(
                      top: 100 + (index * 200) - (_rotationController.value * 50),
                      left: 50 + (index * 80) + (math.sin(_rotationController.value * 2 * math.pi) * 30),
                      child: Container(
                        width: 150 - (index * 30),
                        height: 150 - (index * 30),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              [Colors.cyan, Colors.purple, Colors.pink][index].withOpacity(0.15),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
              
              // Main Content
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    
                    // Glassmorphic Header
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.1),
                            Colors.white.withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.cyan.shade400,
                                  Colors.blue.shade600,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.cyan.withOpacity(0.5),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.whatshot,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'QUANTUM COUNTER',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  'Next-Gen Interface',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AnimatedBuilder(
                            animation: _pulseController,
                            builder: (context, child) {
                              return Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.greenAccent.withOpacity(_pulseController.value),
                                      blurRadius: 10 + (_pulseController.value * 10),
                                      spreadRadius: 2 + (_pulseController.value * 3),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    const Spacer(),
                    
                    // Counter Display
                    BlocBuilder<CounterBloc, CounterStates>(
                      builder: (context, state) {
                        int counter = 0;
                        if (state is changedCounter) {
                          counter = state.counter;
                        }
                        
                        return Column(
                          children: [
                            // Holographic Counter Display
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                // Outer rotating ring
                                AnimatedBuilder(
                                  animation: _rotationController,
                                  builder: (context, child) {
                                    return Transform.rotate(
                                      angle: _rotationController.value * 2 * math.pi,
                                      child: Container(
                                        width: 280,
                                        height: 280,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.cyan.withOpacity(0.3),
                                            width: 2,
                                          ),
                                        ),
                                        child: CustomPaint(
                                          painter: DashedCirclePainter(
                                            color: Colors.cyan.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                
                                // Glow effect
                                AnimatedBuilder(
                                  animation: _pulseController,
                                  builder: (context, child) {
                                    return Container(
                                      width: 250,
                                      height: 250,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.cyan.withOpacity(0.3 + (_pulseController.value * 0.2)),
                                            blurRadius: 60 + (_pulseController.value * 20),
                                            spreadRadius: 10,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                
                                // Main counter circle
                                Container(
                                  width: 240,
                                  height: 240,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.white.withOpacity(0.15),
                                        Colors.white.withOpacity(0.05),
                                      ],
                                    ),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TweenAnimationBuilder<double>(
                                          tween: Tween(begin: 0.7, end: 1.0),
                                          duration: const Duration(milliseconds: 400),
                                          curve: Curves.elasticOut,
                                          builder: (context, scale, child) {
                                            return Transform.scale(
                                              scale: scale,
                                              child: Text(
                                                counter.toString(),
                                                style: TextStyle(
                                                  fontSize: 90,
                                                  fontWeight: FontWeight.w900,
                                                  foreground: Paint()
                                                    ..shader = LinearGradient(
                                                      colors: [
                                                        Colors.cyan.shade200,
                                                        Colors.blue.shade400,
                                                        Colors.purple.shade400,
                                                      ],
                                                    ).createShader(
                                                      const Rect.fromLTWH(0, 0, 200, 100),
                                                    ),
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.cyan.withOpacity(0.8),
                                                      offset: const Offset(0, 0),
                                                      blurRadius: 30,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(
                                              color: Colors.white.withOpacity(0.2),
                                            ),
                                          ),
                                          child: const Text(
                                            'VALUE',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 40),
                            
                            // Status Badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: counter >= 0
                                      ? [Colors.green.shade400, Colors.teal.shade500]
                                      : [Colors.red.shade400, Colors.pink.shade500],
                                ),
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: (counter >= 0 ? Colors.green : Colors.red)
                                        .withOpacity(0.5),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    counter > 0
                                        ? Icons.north_east
                                        : counter < 0
                                            ? Icons.south_east
                                            : Icons.radio_button_checked,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    counter > 0
                                        ? 'ASCENDING'
                                        : counter < 0
                                            ? 'DESCENDING'
                                            : 'EQUILIBRIUM',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    
                    const Spacer(),
                    
                    // Control Panel
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.1),
                            Colors.white.withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Decrease Button
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                context.read<CounterBloc>().decrementCounter();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(
                                    color: Colors.red.withOpacity(0.3),
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.red.shade400,
                                            Colors.pink.shade500,
                                          ],
                                        ),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.red.withOpacity(0.5),
                                            blurRadius: 15,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'MINUS',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(width: 12),
                          
                          // Reset Button (Center)
                          GestureDetector(
                            onTap: () {
                              // Add reset functionality if needed
                            },
                            child: Container(
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.refresh,
                                color: Colors.white70,
                                size: 28,
                              ),
                            ),
                          ),
                          
                          const SizedBox(width: 12),
                          
                          // Increase Button
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                context.read<CounterBloc>().incrementCounter();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.cyan.shade400,
                                      Colors.blue.shade600,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(22),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.cyan.withOpacity(0.5),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.25),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'PLUS',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // BlocListener
      floatingActionButton: BlocListener<CounterBloc, CounterStates>(
        listener: (context, state) {
          if (state is changedCounter) {
            log("State changed with value: ${state.counter}");
            if (state.counter > 5) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.cyan.shade400,
                              Colors.blue.shade600,
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.workspace_premium,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Expanded(
                        child: Text(
                          '⚡ Quantum Threshold Breached!',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: const Color(0xFF203A43),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.all(20),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          }
        },
        child: const SizedBox.shrink(),
      ),
    );
  }
}

// Custom painter for dashed circle
class DashedCirclePainter extends CustomPainter {
  final Color color;
  
  DashedCirclePainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    
    const dashCount = 20;
    const dashAngle = (2 * math.pi) / dashCount;
    
    for (int i = 0; i < dashCount; i += 2) {
      final startAngle = i * dashAngle;
      final sweepAngle = dashAngle * 0.5;
      
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }
  
  @override
  bool shouldRepaint(DashedCirclePainter oldDelegate) => false;
}