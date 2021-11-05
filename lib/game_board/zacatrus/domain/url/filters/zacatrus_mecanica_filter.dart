import 'i_filter.dart';

class ZacatrusMecanicaFilter implements ISingleFilter {
  @override
  final String value;

  const ZacatrusMecanicaFilter({
    required this.value,
  });

  ZacatrusMecanicaFilter.url({
    required String valueUrl,
  }) : value = categoriesUrl.keys
            .firstWhere((key) => categoriesUrl[key] == valueUrl);

  static Iterable<String> get categories => categoriesUrl.keys;

  static Map<String, String> categoriesUrl = {
    "4X": "4x",
    "Arena": "arena",
    "Bazas": "bazas",
    "Colección de sets": "coleccion_de_sets",
    "Colocación de losetas": "colocacion_de_losetas",
    "Colocación de trabajadores": "colocacion_de_trabajadores",
    "Conquista de territorio": "conquista_de_territorio",
    "Crawler": "crawler",
    "Creación de mazo": "creacion_de_mazo",
    "Deducción e Investigación": "deduccion_e_investigacion",
    "Defensa de la Torre": "defensa_de_la_torre",
    "Draft": "draft",
    "Escape room": "escape_room",
    "Evolución de Civilización": "evolucion_de_civilizacion",
    "Exploración y Aventura": "exploracion_y_aventura",
    "Gestión de cartas": "gestion_de_cartas",
    "Gestión de recursos": "gestion_de_recursos",
    "Juegos de palabras": "juegos_de_palabras",
    "Habilidad": "habilidad",
    "LCG": "lcg",
    "Legacy": "legacy",
    "Matemáticas": "matematicas",
    "Mayorías": "mayorias",
    "Memoria": "memoria",
    "Negociación": "negociacion",
    "Pick & Deliver": "pick_deliver",
    "Preguntas y respuestas": "preguntas_y_respuestas",
    "Programación acciones": "programacion_acciones",
    "Puzzle": "puzzle",
    "Roles ocultos": "roles_ocultos",
    "Roll&Write": "roll_write",
    "Sandbox": "sandbox",
    "Subastas": "subastas",
    "Tienta la suerte": "tienta_la_suerte",
    "Wargame": "wargame"
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
      other is ZacatrusMecanicaFilter &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
