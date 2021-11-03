import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/i_filter.dart';

class ZacatrusTematicaFilter implements ISingleFilter {
  final String value;

  const ZacatrusTematicaFilter({
    required this.value,
  });

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
    "Matemáticas": "matematicas_1",
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZacatrusTematicaFilter &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
