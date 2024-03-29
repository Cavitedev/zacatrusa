import 'i_filter.dart';

class ZacatrusMecanicaFilter implements ISingleFilter {
  @override
  final String value;

  const ZacatrusMecanicaFilter({
    required this.value,
  });

  ZacatrusMecanicaFilter.url({
    required String valueUrl,
  }) : value = categoriesUrl.keys.firstWhere((key) => categoriesUrl[key] == valueUrl);

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
    "Flip & Write": "flip_write",
    "Gestión de Acciones": "gestion_de_acciones",
    "Gestión de cartas": "gestion_de_cartas",
    "Gestión de recursos": "gestion_de_recursos",
    "Juegos de palabras": "juegos_de_palabras",
    "Habilidad": "habilidad",
    "LCG": "lcg",
    "Legacy": "legacy",
    "Matemáticas": "matematicas_1",
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
    "Tira y Mueve": "tira_y_mueve",
    "Wargame": "wargame"
  };

  @override
  String? toUrl() => categoriesUrl[value];

  static bool isValidCategory(String category) {
    return categories.contains(category);
  }

  @override
  isValid() => isValidCategory(value);

  static String keyValue = "estilo";

  ZacatrusMecanicaFilter.queryUrl({
    required String value,
  }) : value = categoriesQueryUrl.keys.firstWhere((key) => categoriesQueryUrl[key] == value);

  static Map<String, String> categoriesQueryUrl = {
    "4X": "891",
    "Arena": "1152",
    "Bazas": "1629",
    "Colección de sets": "1016",
    "Colocación de losetas": "7280",
    "Colocación de trabajadores": "1827",
    "Conquista de territorio": "1385",
    "Crawler": "887",
    "Creación de mazo": "932",
    "Deducción e Investigación": "896",
    "Defensa de la Torre": "1172",
    "Draft": "1274",
    "Escape room": "889",
    "Evolución de Civilización": "919",
    "Exploración y Aventura": "897",
    "Gestión de cartas": "7283",
    "Gestión de recursos": "223",
    "Juegos de palabras": "7303",
    "Habilidad": "933",
    "LCG": "886",
    "Legacy": "894",
    "Matemáticas": "7528",
    "Mayorías": "1204",
    "Memoria": "969",
    "Negociación": "892",
    "Pick & Deliver": "1775",
    "Preguntas y respuestas": "219",
    "Programación acciones": "1219",
    "Puzzle": "950",
    "Roles ocultos": "1311",
    "Roll&Write": "1819",
    "Sandbox": "1699",
    "Subastas": "7413",
    "Tienta la suerte": "973",
    "Wargame": "936"
  };

  String toQueryParam() => "$keyValue=${categoriesQueryUrl[value]}&";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZacatrusMecanicaFilter && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;
}
