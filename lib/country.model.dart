class Country {
  final String code;
  final String name;
  final String native;
  final String phone;
  final Continent continent;
  final String currency;
  final List<Language> languages;
  final String emoji;
  final String emojiU;
  final List<State> states;

  Country({
    this.code,
    this.name,
    this.native,
    this.phone,
    this.continent,
    this.currency,
    this.languages,
    this.emoji,
    this.emojiU,
    this.states,
  });

  factory Country.fromJson(Map data) {
    data = data ?? {};

    final continent = Continent.fromJson(data['continent']);

    final languages = data['languages'] != null
        ? (data['languages'] as List<Map>)
            .map((item) => Language.fromJson(item))
            .toList()
        : null;

    final states = data['states'] != null
        ? (data['states'] as List<Map>)
            .map((item) => State.fromJson(item))
            .toList()
        : null;

    return Country(
      code: data['code'] ?? "",
      name: data['name'] ?? "",
      native: data['native'] ?? "",
      phone: data['phone'] ?? "",
      continent: continent,
      currency: data['currency'] ?? "",
      languages: languages,
      emoji: data['emoji'] ?? "",
      emojiU: data['emojiU'] ?? "",
      states: states,
    );
  }
}

class Continent {
  final String code;
  final String name;
  final List<Country> countries;

  const Continent({this.code, this.name, this.countries});

  factory Continent.fromJson(Map data) {
    data = data ?? {};
    final countries = data['countries'] != null
        ? (data['countries'] as List<Map>)
            .map((item) => Country.fromJson(item))
            .toList()
        : null;

    return Continent(
      code: data['code'] ?? "",
      countries: countries,
      name: data['name'] ?? "",
    );
  }
}

class Language {
  final String code;
  final String name;
  final String native;
  final int rtl;

  const Language({this.code, this.name, this.native, this.rtl});

  factory Language.fromJson(Map data) {
    data = data ?? {};
    return Language(
      code: data['code'] ?? "",
      name: data['name'] ?? "",
      native: data['native'] ?? "",
      rtl: data['rtl'] ?? "",
    );
  }
}

class State {
  final String code;
  final String name;
  final Country country;

  const State({this.code, this.name, this.country});

  factory State.fromJson(Map data) {
    data = data ?? {};
    final country =
        data['country'] != null ? Country.fromJson(data['country']) : null;
    return State(
      code: data['code'] ?? "",
      name: data['name'] ?? "",
      country: country,
    );
  }
}
