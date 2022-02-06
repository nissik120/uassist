class Grant{
  final String grantHeading;
  final GrantProviderDetails grantProviderDetails;
  final GrantFinance grantFinance;
  final GrantValidityPeriod grantValidityPeriod;
  final GrantFocus grantFocus;
  final String grantExtraDetails;

  Grant({
    this.grantHeading,
    this.grantProviderDetails,
    this.grantFinance,
    this.grantValidityPeriod,
    this.grantFocus,
    this.grantExtraDetails
  });

  factory Grant.fromJson(Map<String, dynamic> json){
    return Grant(
      grantHeading: json['grantHeading'],
      grantProviderDetails: GrantProviderDetails.fromJson(json['grantProviderDetails']),
      grantFinance: GrantFinance.fromJson(json['grantFinance']),
      grantValidityPeriod: GrantValidityPeriod.fromJson(json['grantValidityPeriod']),
      grantFocus: GrantFocus.fromJson(json['grantFocus']),
      grantExtraDetails: json['grantExtraDetails'],
    );
  }

}

class GrantValidityPeriod {
  final String startDate;
  final String endDate;

  GrantValidityPeriod({
    this.startDate,
    this.endDate
  });

  factory GrantValidityPeriod.fromJson(Map<String, dynamic> json) {
    return GrantValidityPeriod(
      startDate: json['startDate'],
      endDate: json['endDate']
    );
  }

}

class GrantFocus {
  final String grantBrief;
  final List<String> grantRequirements;
  final List<String> targetAgeGroup;
  final List<String> targetLevelGroup;
  final List<String> targetDisciplines;
  final List<String> targetNationality;

  GrantFocus({
    this.grantBrief,
    this.grantRequirements,
    this.targetAgeGroup,
    this.targetLevelGroup,
    this.targetDisciplines,
    this.targetNationality
  });

  factory GrantFocus.fromJson(Map<String, dynamic> json) {
    return GrantFocus(
      grantBrief: json['grantBrief'],
      grantRequirements: (json['grantRequirements'] as List<dynamic>).cast<String>(),
      targetAgeGroup: (json['targetAgeGroup'] as List<dynamic>).cast<String>(),
      targetLevelGroup: (json['targetLevelGroup'] as List<dynamic>).cast<String>(),
      targetDisciplines: (json['targetDisciplines'] as List<dynamic>).cast<String>(),
      targetNationality: (json['targetNationality'] as List<dynamic>).cast<String>(),
    );
  }

}

class GrantFinance {

  final String grantAmount;
  final String grantType;
  final String grantFrequency;

  GrantFinance({
    this.grantAmount,
    this.grantType,
    this.grantFrequency
  });

  factory GrantFinance.fromJson(Map<String, dynamic> json){
    return GrantFinance(
      grantAmount: json['grantAmount'],
      grantType: json['grantType'],
      grantFrequency: json['grantFrequency'],
    );
  }

}

class GrantProviderDetails {
  final String name;
  final String phoneNumber;
  final String email;
  final GrantProviderAddress grantProviderAddress;

  GrantProviderDetails({
    this.name,
    this.phoneNumber,
    this.email,
    this.grantProviderAddress
  });

  factory GrantProviderDetails.fromJson(Map<String, dynamic> json){
    return GrantProviderDetails(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      grantProviderAddress: GrantProviderAddress.fromJson(json['address'])
    );
  }

}

class GrantProviderAddress{
  final String postal;
  final String city;
  final String country;

  GrantProviderAddress({
    this.postal,
    this.city,
    this.country
  });

  factory GrantProviderAddress.fromJson(Map<String, dynamic> json){
    return GrantProviderAddress(
      postal: json['postal'],
      city: json['city'],
      country: json['country']
    );
  }
}