class ZacatrusTematicaFilter {
  final String value;

  const ZacatrusTematicaFilter({
    required this.value,
  });

  static List<String> categories = ["Abstracto", "Agricultura", "Animales", "Arte y Literatura", "Carreras", "Ciencia", "Ciencia Ficción", "Comercio", "Cómic", "Cuentos", "Cyberpunk", "Deportes", "Detectivesca", "Dinosaurios", "Egipto", "Electrónica", "Espada y Brujería", "Fantasía", "Gastronómica", "Historia", "Matemáticas", "Maya", "Medicina", "Medieval", "Misterio", "Mitología", "Música", "Naturaleza", "Oeste", "Oriental", "Piratas", "Politica", "Postapocalíptico", "Steampunk", "Superhéroes", "Terror", "Trenes", "TV/Series/Cine", "Urbano", "Videojuegos", "Vampiros", "Vikingos", "Zombies"];

  static bool isValidCategory(String category) {
    return categories.contains(category);
  }

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
