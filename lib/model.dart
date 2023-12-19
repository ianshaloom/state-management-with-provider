class Dog {
  final String name;
  final String breed;
  int age;
  Dog({required this.name, required this.age, required this.breed});

  void growOlder() {
    age++;
    print('age: $age');
  }
}
