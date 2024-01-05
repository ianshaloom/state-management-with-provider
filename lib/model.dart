import 'package:flutter/material.dart';

class Dog with ChangeNotifier {
  final String name;
  final String breed;
  int age;
  Dog({required this.name, required this.age, required this.breed});

  void growOlder() {
    age++;
    notifyListeners();
  }
}

class Babies {
  int age;

  Babies({required this.age});

  Future<int> getBabies(int age) async {
    await Future.delayed(Duration(seconds: 2));
    return age;
  }

  Stream<double> getBabiesStream() async* {
    // count down from 10 to 0
    for (int i = 10; i >= 0; i--) {
      await Future.delayed(Duration(seconds: 1));
      yield i.toDouble();
    }
  }
}
