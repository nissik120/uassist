class Institution {

  final String institutionName;
  final String institutionAbbreviation;
  final String institutionWebsite;
  final List<String> instituteSpecializations;
  final ContactInfo contactInfo;
  final List<InstituteCourse> instituteCourses;
  final InstituteStatus instituteStatus;

  Institution({
    this.institutionName,
    this.institutionAbbreviation,
    this.institutionWebsite,
    this.instituteSpecializations,
    this.contactInfo,
    this.instituteCourses,
    this.instituteStatus,
  });

  factory Institution.fromJson(Map<String, dynamic> json){

    var courseList = json['instituteCourses'] as List;
    List<InstituteCourse> instituteCourseList = courseList.map((instituteCourse)=> InstituteCourse.fromJson(instituteCourse)).toList();

    return Institution(
      institutionName: json['institutionName'],
      institutionAbbreviation: json['institutionAbbreviation'],
      institutionWebsite: json['institutionWebsite'],
      instituteSpecializations: (json['institutionSpecializations'] as List<dynamic>).cast<String>(),
      contactInfo: ContactInfo.fromJson(json['contactInfo']),
      instituteCourses: instituteCourseList,
      instituteStatus: InstituteStatus.fromJson(json['institutionStatus']),
    );
  }


}

class InstituteStatus {

  final int foundedYear;
  final int countryRank;
  final bool isPublicOwned;
  final bool isNonProfit;
  final String isAccredited;
  final String isRegistered;

  InstituteStatus({
    this.foundedYear,
    this.countryRank,
    this.isPublicOwned,
    this.isNonProfit,
    this.isAccredited,
    this.isRegistered,
  });

  factory InstituteStatus.fromJson(Map<String, dynamic> json){
    return InstituteStatus(
      foundedYear: json['foundedYear'],
      countryRank: json['countryRank'],
      isPublicOwned: json['isPublicOwned'],
      isNonProfit: json['isNonProfit'],
      isAccredited: json['isAccredited'],
      isRegistered: json['isRegistered'],
    );
  }

}

class InstituteCourse {

  final String courseName;
  final String courseAward;
  final String courseLevel;
  final String isAccredited;
  final double courseFeesInMWK;
  final List<String> fields;
  final int courseDurationMonths;

  InstituteCourse({
    this.courseName,
    this.courseAward,
    this.courseLevel,
    this.isAccredited,
    this.courseFeesInMWK,
    this.fields,
    this.courseDurationMonths
  });

  factory InstituteCourse.fromJson(Map<String, dynamic> json){

    double feesInMwk = double.parse(json['courseFeesInMWK']);

    return InstituteCourse(
      courseName: json['courseName'],
      courseAward: json['courseAward'],
      courseLevel: json['courseLevel'],
      courseFeesInMWK: feesInMwk,
      fields: (json['fields'] as List<dynamic>).cast<String>(),
      courseDurationMonths: json['courseDurationMonths'],
    );
  }

}

class ContactInfo {

  final String city;
  final String country;
  final String postalAddress;
  final String phoneNumber;
  final String emailAddress;

  ContactInfo({
    this.city,
    this.country,
    this.postalAddress,
    this.phoneNumber,
    this.emailAddress,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json){
    return ContactInfo(
      city: json['city'],
      country: json['country'],
      postalAddress: json['postalAddress'],
      phoneNumber: json['phoneNumber'],
      emailAddress: json['emailAddress'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'city': city,
      'country': country,
      'postalAddress': postalAddress,
      'phoneNumber': phoneNumber,
      'emailAddress': emailAddress,
    };
  }

}

class InstitutionList{
  final List<Institution> institutions;

  InstitutionList({
    this.institutions,
  });

  factory InstitutionList.fromJson(List<dynamic> json){
    List<Institution> institutions = [];
    return InstitutionList(
      institutions: json.map((i) => Institution.fromJson(i)).toList(),
    );
  }

}