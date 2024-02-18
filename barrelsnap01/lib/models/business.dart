class BusinessModel {
  final String uid;
  final String business_name;
  final String manager_name;
  final DateTime? birthdate;
  final String? phone_number;
  final String? city;
  final String? street;
  final String? street_number;


  BusinessModel({
    required this.uid,
    required this.business_name,
    required this.manager_name,
    this.birthdate,
    this.phone_number,
    this.city,
    this.street,
    this.street_number,

  });
}
