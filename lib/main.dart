import 'dart:developer'; // Correct import for log function

import 'package:bloc_exmaple/bloc/counter_bloc.dart';
import 'package:bloc_exmaple/bloc/counter_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CounterScreen(), // Use the screen from the assignment structure
    );
  }
}

// Move this to counter_screen.dart as per assignment
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            BlocBuilder<CounterBloc, CounterStates>(
              builder: (context, state) {
                if (state is changedCounter) { // Fixed: Uppercase class name
                  return Text(
                    state.counter.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }
                return const Text('0'); // Default value for initial state
              },
            ),
            BlocListener<CounterBloc, CounterStates>(
              listener: (context, state) {
                if (state is changedCounter) { // Fixed: Uppercase class name
                  log("State changed with value: ${state.counter}");
                  if (state.counter > 5) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Counter exceeded 5!'),
                      ),
                    );
                  }
                }
              },
              child: Container(),
            ),
            // Fixed BlocConsumer syntax with both listener and builder
            BlocConsumer<CounterBloc, CounterStates>(
              listener: (context, state) {
                if (state is changedCounter) {
                  log("State changed with value: ${state.counter}");
                  if (state.counter > 5) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Counter exceeded 5!'),
                      ),
                    );
                  }
                }
              },
              builder: (context, state) {
                return Container(); // Placeholder, can be removed if not needed
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                minimumSize: const Size(200, 50),
              ),
              child: const Text('Decrement'),
              onPressed: () {
                context.read<CounterBloc>().decrementCounter();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterBloc>().incrementCounter();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}