import 'i_filter.dart';

class ZacatrusTematicaFilter implements ISingleFilter {
  @override
  final String value;

  const ZacatrusTematicaFilter({
    required this.value,
  });

  ZacatrusTematicaFilter.url({
    required String valueUrl,
  }) : value = categoriesUrl.keys.firstWhere((key) => categoriesUrl[key] == valueUrl);

  static Iterable<String> get categories => categoriesUrl.keys;

  static Map<String, String> categoriesUrl = {
    "Abstracto": "abstracto",
    "Agricultura": "agricultura",
    "Animales": "animales",
    "Arte y Literatura": "arte_literatura",
    "Carreras": "carreras",
    "Ciencia": "ciencia",
    "Ciencia Ficción": "ciencia_ficcion",
    "Comercio": "comercio",
    "Cómic": "comic",
    "Cuentos": "cuentos",
    "Cyberpunk": "cyberpunk",
    "Deportes": "deportes",
    "Detectivesca": "detectives",
    "Dinosaurios": "dinosaurios",
    "Egipto": "egipto",
    "Electrónica": "electronica",
    "Espada y Brujería": "espada_brujeria",
    "Fantasía": "fantasia",
    "Gastronómica": "gastronomica",
    "Historia": "historia",
    "Matemáticas": "matematicas",
    "Maya": "maya",
    "Medicina": "medicina",
    "Medieval": "medieval",
    "Misterio": "misterio",
    "Mitología": "mitologia",
    "Música": "musica",
    "Naturaleza": "naturaleza",
    "Oeste": "oeste",
    "Oriental": "oriental",
    "Piratas": "piratas",
    "Politica": "politica",
    "Postapocalíptico": "postapocaliptico",
    "Prehistoria": "prehistoria",
    "Steampunk": "steampunk",
    "Superhéroes": "superheroes",
    "Terror": "terror",
    "Trenes": "trenes",
    "TV/Series/Cine": "cine",
    "Urbano": "urbano",
    "Videojuegos": "videojuegos",
    "Vampiros": "vampiros",
    "Vikingos": "vikingos",
    "Zombies": "zombie"
  };

  @override
  String? toUrl() => categoriesUrl[value];

  static bool isValidCategory(String category) {
    return categories.contains(category);
  }

  @override
  isValid() => isValidCategory(value);

  static String keyValue = "tema_sel";

  ZacatrusTematicaFilter.queryUrl({
    required String value,
  }) : value = categoriesQueryUrl.keys.firstWhere((key) => categoriesQueryUrl[key] == value);

  static Map<String, String> categoriesQueryUrl = {
    "Abstracto": "935",
    "Agricultura": "915",
    "Animales": "909",
    "Arte y Literatura": "1451",
    "Carreras": "964",
    "Ciencia": "7284",
    "Ciencia Ficción": "925",
    "Comercio": "914",
    "Cómic": "1049",
    "Cuentos": "970",
    "Cyberpunk": "1135",
    "Deportes": "1120",
    "Detectivesca": "939",
    "Dinosaurios": "1793",
    "Egipto": "1058",
    "Electrónica": "951",
    "Espada y Brujería": "908",
    "Fantasía": "1826",
    "Gastronómica": "1012",
    "Historia": "918",
    "Matemáticas": "7511",
    "Maya": "1212",
    "Medicina": "1222",
    "Medieval": "983",
    "Misterio": "7279",
    "Mitología": "931",
    "Naturaleza": "978",
    "Oeste": "1142",
    "Oriental": "1004",
    "Piratas": "1077",
    "Politica": "1312",
    "Postapocalíptico": "1186",
    "Steampunk": "1060",
    "Superhéroes": "962",
    "Terror": "928",
    "Trenes": "1040",
    "TV/Series/Cine": "1025",
    "Urbano": "1420",
    "Videojuegos": "1333",
    "Vampiros": "7479",
    "Vikingos": "959",
    "Zombies": "956",
    "Música": "1376"
  };

  String toQueryParam() => "$keyValue=${categoriesQueryUrl[value]}&";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZacatrusTematicaFilter && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;
}
