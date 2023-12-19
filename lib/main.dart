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
    //NOTE - Provider Widget Initialization

    /** -------------------------------------------------------------------------- *
     * When we use the Provider widget, we need to specify the type of data we want to provide.
     * In this case, we want to provide a Dog object, so we specify Dog as the type.
     * The create parameter is a callback that returns the data we want to provide.
     * By doing so the Dog object will be accessible to all the widgets in the widget tree below the Provider widget.
     * -------------------------------------------------------------------------- *
     */

    return Provider<Dog>(
      create: (_) => Dog(name: 'Fido', age: 3, breed: 'Labrador'),
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
        title: Text('Provider 01'),
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
            //NOTE - Accessing the Dog object from the widget tree below the Provider widget
            /**
             * -------------------------------------------------------------------------- *
             * To access the Dog object from the widget tree below the Provider widget, we use the Provider.of() method.
             * 
             * We call the Provider.of() method with type Dog as generic type parameter.
             * This means that the Provider.of() method will return a Dog object only.
             * If there are two or more instances of the Dog class in the widget tree,
             * the Provider.of() method will return the nearest Dog object.
             * 
             * The Provider.of() method takes the BuildContext as a parameter and returns the Dog object.
             * The BuildContext is used to find the nearest Provider widget in the widget tree.
             * -------------------------------------------------------------------------- *
             */
            Text(
              '- dog Name: ${Provider.of<Dog>(context).name}',
            ),
            const SizedBox(height: 20.0),
            BreedAndAge(),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class BreedAndAge extends StatelessWidget {
  const BreedAndAge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '- dog Breed: ${Provider.of<Dog>(context).breed}',
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
    return Column(
      children: [
        Text(
          '- dog Age: ${Provider.of<Dog>(context).age}',
        ),
        const SizedBox(height: 20.0),
        FilledButton(
          onPressed: Provider.of<Dog>(context, listen: false).growOlder,
          child: const Text('Add'),
        )
      ],
    );
  }
}
