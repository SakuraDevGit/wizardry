class SpellEntity {
  final String id;
  final String name;
  final String incantation;
  final String effect;
  final bool canBeVerbal;
  final String type;
  final String light;
  final String creator;

  SpellEntity({
    required this.id,
    required this.name,
    required this.incantation,
    required this.effect,
    required this.canBeVerbal,
    required this.type,
    required this.light,
    required this.creator,
  });
}
