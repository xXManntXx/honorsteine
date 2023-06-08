class StolpersteineData {
  final int id;
  final String name;
  final String reasonOfPersecussion;
  final String address;
  final String city;
  final bool official;
  final String birthDate;
  final String deathDate;
  final String deathPlace;
  final String gender;
  final String photoLink;
  final String url;
  final String niodUrl;
  final String mapUrl;
  final List<double> location;

  const StolpersteineData({
    required this.id,
    required this.name,
    required this.reasonOfPersecussion,
    required this.address,
    required this.official,
    required this.birthDate,
    required this.deathDate,
    required this.deathPlace,
    required this.gender,
    required this.photoLink,
    required this.url,
    required this.niodUrl,
    required this.mapUrl,
    required this.location,
    required this.city,
  });

  factory StolpersteineData.fromJson(Map<String, dynamic> APIdata) {
    return StolpersteineData(
      id: APIdata['id'],
      name: APIdata['name'].toString(),
      reasonOfPersecussion: APIdata['reasonOfPassing'].toString(),
      address: APIdata['address'].toString(),
      official: APIdata['officialStone'],
      birthDate: APIdata['dateOfBirth'].toString(),
      deathDate: APIdata['dateOfPassing'].toString(),
      deathPlace: APIdata['placeOfPassing'].toString(),
      gender: APIdata['gender'].toString(),
      photoLink: APIdata['photo'].toString(),
      url: APIdata['url'].toString(),
      niodUrl: APIdata['niodUrl'].toString(),
      mapUrl: APIdata['mapUrl'].toString(),
      location: [APIdata['location']['lat'], APIdata['location']['long']],
      city: APIdata['city'].toString(),
    );
  }
}