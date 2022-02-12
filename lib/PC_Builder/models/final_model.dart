class PC {
  final String line;

  PC({
    required this.line,
  });

  factory PC.fromJson(dynamic json) {
    // print('2');
    return PC(
      line: json as String,
    );
  }
}
