class DummyObject {
  DummyObject(this.text);

  factory DummyObject.create() => DummyObject(
        List.generate(1024, (_) => '0').fold('', (a, b) => a + b),
      );

  final String text;
}
