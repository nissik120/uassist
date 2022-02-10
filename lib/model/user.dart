import 'package:uassist/model/user_xp.dart';

class MyUser {
  final String imagePath;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String phoneNumber;
  final String postalAddress;
  final String residenceAddress;
  final String email;
  final List<UserXP> education;
  final List<UserXP> work;
  final List<String> hobbies;
  final List<String> interests;
  final List<String> traits;


  MyUser({
    this.imagePath,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.phoneNumber,
    this.email,
    this.postalAddress,
    this.residenceAddress,
    this.education,
    this.work,
    this.hobbies,
    this.interests,
    this.traits,
  });

  factory MyUser.createEmpty(){
    return MyUser(
      imagePath: "",
      firstName: "",
      lastName: "",
      dateOfBirth: "",
      phoneNumber: "",
      email: "",
      postalAddress: "",
      residenceAddress: "",
      education:  [],
      work: [],
      hobbies: [],
      interests: [],
      traits: [],
    );
  }

  factory MyUser.fromJson(dynamic json){

    final educationList = json['education'] as List;
    List<UserXP> education = educationList!=null ? educationList.map((i) => UserXP.fromJson(i)).toList() : [];
    final workList = json['work'] as List;
    List<UserXP> work = workList!=null ? workList.map((i) => UserXP.fromJson(i)).toList() : [];

    return MyUser(
      imagePath: json['imagePath'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      dateOfBirth: json['dateOfBirth'],
      phoneNumber: json['phoneNumber'],
      postalAddress: json['postalAddress'],
      residenceAddress: json['residenceAddress'],
      email: json['email'],
      education: education,
      work: work,
      hobbies: (json['hobbies'] as List<dynamic>).cast<String>(),
      interests: (json['interests'] as List<dynamic>).cast<String>(),
      traits: (json['traits'] as List<dynamic>).cast<String>(),
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'imagePath': imagePath,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'phoneNumber': phoneNumber,
      'postalAddress': postalAddress,
      'residenceAddress': residenceAddress,
      'email': email,
      'education': education.map((educationItem) => educationItem.toMap()).toList(growable: false),
      'work': work.map((workItem) => workItem.toMap()).toList(growable: false),
      'interests': interests,
      'traits': traits,
      'hobbies': hobbies,
    };
  }

  static MyUser fromMap(Map<String, dynamic> map){
    return MyUser(
      imagePath: map['imagePath'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      dateOfBirth: map['dateOfBirth'],
      phoneNumber: map['phoneNumber'],
      postalAddress: map['postalAddress'],
      residenceAddress: map['residenceAddress'],
      email: map['email'],
      education: map['education'].map((mapping)=>UserXP.fromMap(mapping)).toList().toCast<UserXP>(),
      work: map['work'].map((mapping)=>UserXP.fromMap(mapping)).toList().toCast<UserXP>(),
      hobbies: map['extras']['hobbies'],
      interests: map['extras']['interests'],
      traits: map['extras']['traits'],
    );
  }

  @override
  String toString() {
    return 'User(imagePath: $imagePath, firstName: $firstName, lastName: $lastName, dateOfBirth: $dateOfBirth, phoneNumber: $phoneNumber, postalAddress: $postalAddress, residenceAddress: $residenceAddress, email: $email, education: $education, work: $work, interests: $interests, traits: $traits, hobbies: $hobbies,)';
  }

  MyUser copyWith({
    String imagePath,
    String firstName,
    String lastName,
    String dateOfBirth,
    String phoneNumber,
    String postalAddress,
    String residenceAddress,
    String email,
    List<UserXP> education,
    List<UserXP> work,
    List<String> hobbies,
    List<String> interests,
    List<String> traits,
  }){
    return MyUser(
      imagePath: imagePath ?? this.imagePath,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      postalAddress: postalAddress ?? this.postalAddress,
      residenceAddress: residenceAddress ?? this.residenceAddress,
      email: email ?? this.email,
      education: education ?? this.education,
      work: work ?? this.work,
      interests: interests ?? this.interests,
      traits: traits ?? this.traits,
      hobbies: hobbies ?? this.hobbies,
    );
  }

}