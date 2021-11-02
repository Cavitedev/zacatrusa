class ZacatrusEditorialFilter {
  final String value;

  const ZacatrusEditorialFilter({
    required this.value,
  });

  static List<String> categories = ["Zacatrus", "2 Tomatoes", "2D10 Games", "Abba Games", "Afrogames", "Alea", "Amphora Games", "Anima-T", "Ankama", "APA Boardgames", "Aquamarine", "Archon Studio", "Ares games", "Arquitectura a contrapelo", "Arrakis Games", "Artipia Games", "Asmodée", "Asylum Games", "Átomo Games", "Avalon Hill", "Bezier Games", "Bioviva", "Blauberry", "Blue Orange", "Bridge Bandit", "Bumble3ee", "Burning Games", "Buró de Juegos", "Cacahuete Games", "Cayro", "Cerebrer Games", "CGE - Czech Games Edition", "Circoctel", "Class Games", "CMON", "Cocktail Games", "ConBarba", "Corvus Belli", "Cosplay Original", "Crazy Pawn", "Ctrlaltcreative", "Darbel", "Days of Wonder", "Delirium Games", "Devir", "Diset", "Dizemo", "Djeco", "DMZ games", "Do It", "Draco Ideas", "Druid City Games", "Eagle Games", "Eclipse Editorial", "Edge Entertainment", "Ediciones Primigenio", "Edigrafica", "Educa", "El Troquel", "En Movimiento 360", "Enuntris", "Excalibur", "Extended Play", "Falomir", "Fantasy Flight", "Ferti", "Fesme Games", "Flying Frog Production", "Fractal Juegos", "Funko", "Gabinete Lúdico", "Gale Force Nine", "Game Brewer", "Games for Gamers", "Games Workshop", "GDM Games", "Gen X Games", "Gigamic", "Giochi Uniti", "Giochix", "GMT", "Gnomosaurus", "Goliath", "Haba", "Hasbro", "Haus of Glitter", "Holocubierta", "Homoludicus", "Huch & Friends", "Hurrican Games", "IDW Games", "Iello", "invedars", "JAM", "Juegorama", "Kibo", "Kodomo", "Kosmos", "Koti Games", "La Mame Games", "La Pinta Games", "Last Level", "Libellud", "Longalive Games", "Lookout Games", "Looping Games", "Lucky Duck Games", "Ludic", "Ludically", "Ludilo", "Ludoismo", "Ludonaute", "Ludonova", "LudoSentinel", "Ludotecnia", "Lui-Méme", "Magic Box Games", "Maldito Games", "MasQueOca", "Matagot", "Mattel", "Mebo", "Megacorpin Games", "Melmac Games", "Mercurio", "Meridiano 6", "Mixingames", "Mont Taber", "Mystical Games", "Next Move", "No game over", "Nosolorol", "Nostromo Games", "Oink Games", "Paizo", "Pavana Games", "Pearl Games", "Pegasus Spiele", "Peka", "Pendragon", "Perro Loko Games", "Petersen Games", "Pinbro Games", "PiroJoc", "Plaid Hat Games", "Plan B Games", "PlastCraft Games", "Portal Publishing", "Pythagoras", "Queen Games", "Qworkshop", "R&R Games", "Ravensburger", "Rebel", "Red Glove", "Repos Production", "República Bananera", "Reverse Games", "Rio Grande Games", "Rocket Lemon Games", "Salt & Pepper Games", "Scale Games", "Schmidt", "SD Games", "Shining Creations", "Smart Troll Games", "SmartPlay", "SombraDist", "Space Cowboys", "Steamforged Games LTD.", "Steve Jackson Games", "T Tower Games", "TCG", "Tetrakis", "The Game Forger", "Thinkfun", "Thundergryph Games", "Tortugames", "Tranjis", "Txarly Factory", "Van Ryder Games", "Vedra", "Viravi", "White Goblin Games", "Wizards of the Coast", "Wizkids", "Ystari Games", "Z-Man Games", "Zombi Paella"];

  static bool isValidCategory(String category) {
    return categories.contains(category);
  }

  isValid() => isValidCategory(value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZacatrusEditorialFilter &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
