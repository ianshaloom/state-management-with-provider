import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import 'model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dog = Dog(name: 'Fido', age: 3, breed: 'Labrador');

  @override
  void initState() {
    super.initState();
    dog.addListener(dogListener);
  }

  void dogListener() {
    print('********* dogs age ${dog.age} *********\n');
    setState(() {});
  }

  @override
  void dispose() {
    dog.removeListener(dogListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('********* I have been  rebuilt _MyHomePageState *********\n');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Provider 02'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: const Text(
                'Accessing the Dog object from the widget tree below the Provider widget',
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 150.0),
            Text(
              '- dog Name: ${dog.name}',
            ),
            const SizedBox(height: 20.0),
            BreedAndAge(
              dog: dog,
            ),
          ],
        ),
      ), 
    );
  }
}

class BreedAndAge extends StatelessWidget {
  final Dog dog;
  const BreedAndAge({
    super.key,
    required this.dog,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '- dog Breed: ${dog.breed}',
        ),
        const SizedBox(height: 20.0),
        Age(
          dog: dog,
        ),
      ],
    );
  }
}

class Age extends StatelessWidget {
  final Dog dog;
  const Age({
    super.key,
    required this.dog,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '- dog Age: ${dog.age}',
        ),
        const SizedBox(height: 20.0),
        FilledButton(
          onPressed: dog.growOlder,
          child: const Text('Add'),
        )
      ],
    );
  }
}
