class AirtableDataCandidate {
  String id;
  String nom;
  String prenom;
  String photo;
  String statut;
  String telephone;
  String mail;
  String localisation;
  List<String> realisations;
  String match;
  double lat;
  double long;

  AirtableDataCandidate({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.photo,
    required this.statut,
    required this.telephone,
    required this.mail,
    required this.localisation,
    required this.realisations,
    required this.lat,
    required this.long,
    required this.match,
  });
}
