class Vacancies{
  final String company;
  final String jobTitle;
  final String jobDescription;
  final String jobUrl;
  final String jobType;
  final String datePosted;
  final String location;
  final List<String> skills;
  final SalaryDetails salaryDetails;
  final List<String> jobPerks;

  Vacancies({
    this.company,
    this.jobTitle,
    this.jobDescription,
    this.jobUrl,
    this.jobType,
    this.datePosted,
    this.location,
    this.skills,
    this.salaryDetails,
    this.jobPerks
  });

  factory Vacancies.fromJson(Map<String, dynamic> json){
    return Vacancies(
      company: json['company'],
      jobTitle: json['title'],
      jobDescription: json['description'],
      jobType: json['type'],
      jobUrl: json['url'],
      datePosted: json['posted'],
      location: json['location'],
      salaryDetails: SalaryDetails.fromJson(json['salaryRange']),
      skills: (json['skills'] as List<dynamic>).cast<String>(),
      jobPerks: (json['perks'] as List<dynamic>).cast<String>()
    );
  }



}

class SalaryDetails {
  final int minSalary;
  final int maxSalary;
  final String currencySalary;

  SalaryDetails({this.minSalary, this.maxSalary, this.currencySalary});

  factory SalaryDetails.fromJson(Map<String, dynamic> json){
    return SalaryDetails(
      minSalary: json['from'],
      maxSalary: json['to'],
      currencySalary: json['currency']
    );
  }

}