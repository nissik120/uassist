class UserXP{
  final String title;
  final String institution;
  final String startDate;
  final String endDate;
  final String extraDetails;

  UserXP({
    this.title,
    this.institution,
    this.startDate,
    this.endDate,
    this.extraDetails,
  });

  factory UserXP.createEmpty(){
    return UserXP(
      title: "",
      institution: "",
      startDate: "",
      endDate: "",
      extraDetails: "",
    );
  }

  factory UserXP.fromJson(dynamic json){
    return UserXP(
      title: json['title'] as String,
      institution: json['institution'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      extraDetails: json['extraDetails'] as String,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'title': title,
      'institution': institution,
      'startDate': startDate,
      'endDate': endDate,
      'extraDetails': extraDetails,
    };
  }

  static UserXP fromMap(Map<String, dynamic> map){
    return UserXP(
        title: map['title'],
        institution: map['institution'],
        startDate: map['startDate'],
        endDate: map['endDate'],
        extraDetails: map['extraDetails'],
    );
  }

  @override
  String toString() {
    return 'UserXP{ title: $title, institution: $institution, startDate: $startDate, endDate: $endDate, extraDetails: $extraDetails,}';
  }

  UserXP copyWith({
    String title,
    String institution,
    String startDate,
    String endDate,
    String extraDetails,
  }){
    return UserXP(
      title: title ?? this.title,
      institution: institution ?? this.institution,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      extraDetails: extraDetails ?? this.extraDetails,
    );
  }


}