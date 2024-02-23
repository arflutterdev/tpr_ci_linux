import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RSavedLocations {
  final String label;
  final num c1;
  final num c2;
  final num c3;
  final num c4;
  final num c5;
  final num c6;
  RSavedLocations({
    required this.label,
    required this.c1,
    required this.c2,
    required this.c3,
    required this.c4,
    required this.c5,
    required this.c6,
  });

  RSavedLocations copyWith({
    String? label,
    num? c1,
    num? c2,
    num? c3,
    num? c4,
    num? c5,
    num? c6,
  }) {
    return RSavedLocations(
      label: label ?? this.label,
      c1: c1 ?? this.c1,
      c2: c2 ?? this.c2,
      c3: c3 ?? this.c3,
      c4: c4 ?? this.c4,
      c5: c5 ?? this.c5,
      c6: c6 ?? this.c6,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'label': label,
      'c1': c1,
      'c2': c2,
      'c3': c3,
      'c4': c4,
      'c5': c5,
      'c6': c6,
    };
  }

  factory RSavedLocations.fromMap(Map<String, dynamic> map) {
    return RSavedLocations(
      label: map['label'] as String,
      c1: map['c1'] as num,
      c2: map['c2'] as num,
      c3: map['c3'] as num,
      c4: map['c4'] as num,
      c5: map['c5'] as num,
      c6: map['c6'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSavedLocations.fromJson(String source) =>
      RSavedLocations.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RSavedLocations(label: $label, c1: $c1, c2: $c2, c3: $c3, c4: $c4, c5: $c5, c6: $c6)';
  }

  @override
  bool operator ==(covariant RSavedLocations other) {
    if (identical(this, other)) return true;
  
    return 
      other.label == label &&
      other.c1 == c1 &&
      other.c2 == c2 &&
      other.c3 == c3 &&
      other.c4 == c4 &&
      other.c5 == c5 &&
      other.c6 == c6;
  }

  @override
  int get hashCode {
    return label.hashCode ^
      c1.hashCode ^
      c2.hashCode ^
      c3.hashCode ^
      c4.hashCode ^
      c5.hashCode ^
      c6.hashCode;
  }
}

List<RSavedLocations> savedlocsFromString(String data) {
  List<RSavedLocations> savedLocations = [];
  // var ts =
  //     'Dock,0.0,0.0,0.0,0.0,0.0,1.0,MeetingRoom,0,0,0,0,0,1,CRoom,0,0,0,0,0,1,BRoom,0,0,0,0,0,1,KRoom,0,0,0,0,0,1';
  var splitted = data.split(',');

  var totalNumberOfItems = splitted.length / 7;
  int labelIndex = 0;
  for (int i = 0; i < totalNumberOfItems; i++) {
    print(i);
    int ci = i * 7;
    savedLocations.add(RSavedLocations(
      label: splitted[ci],
      c1: num.parse(splitted[ci + 1]),
      c2: num.parse(splitted[ci + 2]),
      c3: num.parse(splitted[ci + 3]),
      c4: num.parse(splitted[ci + 4]),
      c5: num.parse(splitted[ci + 5]),
      c6: num.parse(splitted[ci + 6]),
    ));
  }

  // print(savedLocations);
  return savedLocations;
}
