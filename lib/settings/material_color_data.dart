import 'package:flutter/material.dart';

class MaterialColorData {
  final String msg;
  final MaterialColor color;

  const MaterialColorData({
    required this.msg,
    required this.color,
  });

  factory MaterialColorData.fromIndex(int index) {
    return MaterialColorData(
      msg: materialColorNames[index],
      color: Colors.primaries[index],
    );
  }

  static const List<String> materialColorNames = [
    "Rojo",
    "Rosa",
    "Lila",
    "Morado",
    "Añil",
    "Azul",
    "Azul Claro",
    "Turquesa",
    "Verde azulado",
    "Verde",
    "Verde Claro",
    "Lima",
    "Amarillo",
    "Ámbar",
    "Naranja",
    "Naranja Intenso",
    "Marrón",
    "Gris"
  ];
}
