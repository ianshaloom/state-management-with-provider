import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Dog>(
      create: (_) => Dog(
        name: 'Fido',
        age: 3,
        breed: 'Labrador',
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
                'read, watch, select extension methods',
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 150.0),
            //NOTE
            /**
             * The Dog object is accessed from the widget tree below the Provider widget
             * But since the Dog name property is final, it cannot be changed
             * So we can use listen: false to prevent the widget from rebuilding when the Dog object changes
             */
            Text(
              '- dog Name: ${context.watch<Dog>().name}',
            ),
            const SizedBox(height: 20.0),
            BreedAndAge(),
          ],
        ),
      ),
    );
  }
}

class BreedAndAge extends StatelessWidget {
  const BreedAndAge({super.key});

  @override
  Widget build(BuildContext context) {
    print('********* I have been  rebuilt _BreedAndAgeState *********\n');
    return Column(
      children: [
        Text(
          '- dog Breed: ${context.select((Dog dog) => dog.breed)}',
        ),
        const SizedBox(height: 20.0),
        Age(),
      ],
    );
  }
}

class Age extends StatelessWidget {
  const Age({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('********* I have been  rebuilt _AgeState *********\n');
    return Column(
      children: [
        Text(
          //NOTE
          /**
           * The Dog object is accessed from the widget tree below the Provider widget
           * But since the Dog age property is not final, it can be changed
           * By using select with generic type dog and int,
           * the widget will rebuild only when the Dog object int property changes
           */
          '- dog Age: ${context.select<Dog,int>((Dog dog) => dog.age)}',
        ),
        const SizedBox(height: 20.0),
        FilledButton(
          //NOTE
          /**
           * The Dog object is accessed from the widget tree below the Provider widget
           * But since the Dog growOlder method is called, the widget will rebuild when the Dog object changes
           * So we can use listen: false to prevent the widget from rebuilding when the Dog object changes
           */
          onPressed: context.read<Dog>().growOlder,
          child: const Text('Add'),
        )
      ],
    );
  }
}
