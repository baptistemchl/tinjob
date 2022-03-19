class AirtableDataCompany {
  String id;
  String nom;
  String activite;
  String description;
  String poste;
  String telephone;
  String mail;
  String logo;
  double lat;
  double long;

  AirtableDataCompany({
    required this.id,
    required this.nom,
    required this.activite,
    required this.description,
    required this.poste,
    required this.telephone,
    required this.mail,
    required this.logo,
    required this.lat,
    required this.long,
  });

  factory AirtableDataCompany.fromJson(Map<String, dynamic> json) {
    return AirtableDataCompany(
      id: json['id'],
      nom: json['fields']['nom'],
      activite: json['fields']['activite'],
      description: json['fields']['description'],
      poste: json['fields']['poste'],
      telephone: json['fields']['telephone'],
      mail: json['fields']['mail'],
      logo: json['fields']['logo'][0]['url'],
      lat: json['fields']['lat'],
      long: json['fields']['long'],
    );
  }
}
