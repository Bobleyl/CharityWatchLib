class Charity {
  final String uid;
  final String charity;
  final String url;
  final String effectiveness;
  final String grade;
  final String category;

  const Charity({
    this.category,
    this.uid,
    this.url,
    this.effectiveness,
    this.grade,
    this.charity,
  });
  factory Charity.fromJson(Map<String, dynamic> json) {
    return Charity(
      uid: json['uid'].toString(),
      category: json['category'].toString(),
      url: json['url'].toString(),
      effectiveness: json['effectiveness'].toString(),
      grade: json['grade'].toString(),
      charity: json['charity'].toString(),
    );
  }
}
