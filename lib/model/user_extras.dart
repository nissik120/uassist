class UserExtras{

  final List<String> hobbies;
  final List<String> interests;
  final List<String> traits;

  UserExtras({
    this.hobbies,
    this.interests,
    this.traits,
  });

  factory UserExtras.fromJson(Map<String, dynamic> parsedJson){
    var hobbiesFromJson = parsedJson['hobbies'];
    List<String> hobbiesList = hobbiesFromJson.cast<String>();

    var interestsFromJson = parsedJson['interests'];
    List<String> interestsList = interestsFromJson.cast<String>();

    var traitsFromJson = parsedJson['traits'];
    List<String> traitsList = traitsFromJson.cast<String>();

    return new UserExtras(
      interests: interestsList,
      traits: traitsList,
      hobbies: hobbiesList,
    );
  }

  UserExtras copyWith({
    List<String> hobbies,
    List<String> interests,
    List<String> traits,
  }){
    return UserExtras(
      hobbies: hobbies ?? this.hobbies,
      interests: interests ?? this.interests,
      traits: traits ?? this.traits,
    );
  }

}