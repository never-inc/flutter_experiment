class DummyObject {
  DummyObject(this.text);

  factory DummyObject.create() {
    final buffer = StringBuffer();
    for (var i = 0; i < 1024; i++) {
      buffer.write(i);
    }
    return DummyObject(buffer.toString());
  }

  final String text;
}
