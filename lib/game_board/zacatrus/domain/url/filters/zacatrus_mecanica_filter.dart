class ZacatrusMecanicaFilter {
  final String value;

  const ZacatrusMecanicaFilter({
    required this.value,
  });

  static List<String> categories = ["4X", "Arena", "Bazas", "Colección de sets", "Colocación de losetas", "Colocación de trabajadores", "Conquista de territorio", "Crawler", "Creación de mazo", "Deducción e Investigación", "Defensa de la Torre", "Draft", "Escape room", "Evolución de Civilización", "Exploración y Aventura", "Gestión de cartas", "Gestión de recursos", "Juegos de palabras", "Habilidad", "LCG", "Legacy", "Matemáticas", "Mayorías", "Memoria", "Negociación", "Pick & Deliver", "Preguntas y respuestas", "Programación acciones", "Puzzle", "Roles ocultos", "Roll&Write", "Sandbox", "Subastas", "Tienta la suerte", "Wargame"];

  static bool isValidCategory(String category) {
    return categories.contains(category);
  }

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
